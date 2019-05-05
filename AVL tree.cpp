#include<iostream>
#include<math.h>
using namespace std;
class node
{
	public:
	int data;
	node *left,*right;
	node(int x)
	{
		data=x;
		left=right=NULL;
	}
};

class avl
{
	node *root;
	public:
	avl()
	{
		root=NULL;
	}
	
	void create()
	{
		int x;
		do
		{
		
			cout<<"Enter data or -1 to stop\n";
			cin>>x;
			if(x==-1)
			{
				break;
			}
			root=insert(root,x);
		}
	while(1);
	}
	
	
	int height(node *t)
	{
		int lh=0,rh=0;
		if(t==NULL)
		{
			return 0;
		}
		if(t->left==NULL&&t->right==NULL)
		{
			return 0;
		}
		if(t->left!=NULL)
		{
			lh=1+height(t->left);
		}
		if(t->right!=NULL)
		{
			rh=1+height(t->right);
		}
		if(lh>rh)
		{
			return lh;
		}
		else
		{
			return rh;
		}
	}
	
	int balfactor(node *t)
	{
		int lh=0,rh=0;
		if(t->left!=NULL)
		{
			lh=1+height(t->left);
		}
		if(t->right!=NULL)
		{
			rh=1+height(t->right);
		}
		return abs(lh-rh);
	}
	
	node *insert(node *t,int x)
	{
		if(t==NULL)
		{
			return new node(x);
		}
		if(x<t->data)
		{
			t->left=insert(t->left,x);
			if(balfactor(t)==2)
			{
				if(x<t->left->data)
				{
					t=ll(t);
				}
				else
				{
					t=lr(t);
				}
			}
			return t;
	
		}
		
		if(x>t->data)
		{
			t->right=insert(t->right,x);
			if(balfactor(t)==2)
			{
				if(x>t->right->data)
				{
					t=rr(t);
				}
				else
				{
					t=rl(t);
				}
			}
			return t;
		}
		
		
	}
	
	void inorder()
	{
		inorder_rec(root);
	}
	
	void inorder_rec(node *t)
	{
		if(t!=NULL)
		{
			inorder_rec(t->left);
			cout<<t->data<<" "<<balfactor(t)<<" "<<height(t)<<endl;
			inorder_rec(t->right);
		}
	}
	
	node *ll(node *t)
	{
		node *y=t->left;
		t->left=y->right;
		y->right=t;
		return y;
	}
	
	node *rr(node *t)
	{
		node *y=t->right;
		t->right=y->left;
		y->right=t;
		return y;
	}
	
	node *lr(node *t)
	{
		node *y=t->left;
		node *p=y->right;
		y->right=p->left;
		p->left=y;
		t->left=p;
		t=ll(t);
		return t;
	}
	
	
	node *rl(node *t)
	{
		node *y=t->right;
		node *p=y->left;
		y->left=p->right;
		p->right=y;
		t->right=p;
		t=rr(t);
		return t;
	}
	
	
	void delete1()
	{
		int x;
		while(1)
		{
		
		cout<<"Enter data to delete\n";
		cin>>x;
		if(x==-1)
		{
			return ;
		}
		root=delete_rec(root,x);
	};
	}
	
	node *delete_rec(node *t,int x)
	{
		if(t==NULL)
		{
			cout<<"Empty\n";
			return NULL;
		}
		if(x<t->data)
		{
			t->left=delete_rec(t->left,x);
			if(balfactor(t)==-2)
			{
				if(balfactor(t->right)<0)
				{
					t=rr(t);
				}
				else
				{
					t=rl(t);
				}
			}
			return t;
		}
		
		if(x>t->data)
		{
			t->right=delete_rec(t->right,x);
			if(balfactor(t)==2)
			{
				if(balfactor(t->left)>=0)
				{
					t=ll(t);
				}
				else
				{
					t=lr(t);
				}
			}
			return t;
		}
		
		if(t->left==NULL&&t->right==NULL)
		{
			delete t;
			return NULL;
		}
		if(t->right==NULL)
		{
			node *p=t->left;
			delete p;
			return t;
		}
		
		node *p=t->right;
		while(p->left!=NULL)
		{
			p=p->left;
		}
		t->data=p->data;
		t->right=delete_rec(t->right,p->data);
		if(balfactor(t)==2)
			{
				if(balfactor(t->left)>=0)
				{
					t=ll(t);
				}
				else
				{
					t=lr(t);
				}
			}
			return t;
		
		
	}
	

};

int main()
{
	avl a;
	a.create();
	a.inorder();
	a.delete1();
	a.inorder();


}

