Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEA929FC50
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Oct 2020 04:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgJ3DwG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 23:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3DwF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 23:52:05 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09D6C0613CF;
        Thu, 29 Oct 2020 20:52:05 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id k1so5325042ilc.10;
        Thu, 29 Oct 2020 20:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g/nqsGSCHKloMIgPNixbOCkctkUj9nB1nJ1CL7OwKos=;
        b=J5CKjI78b8bSSgEUyQzn8s7/mFVnfJksa5xqymZgTxWYbhg++UMO0/flvDOTMgd1M2
         VxF4Uxt3MxcdpJK5vvP+mYbDx87OvowzHoSbXp1NPzNWppOQ3BLD4zrJ3xc1tW0XDpCR
         Y7Y5iSgrecwUVfn8tcwoNJEIBfcP4ma+QbDdx0FCwJ6lS7tyU9uUGAgvmStRblNqRRAe
         nnWu6pMSK2VIdfecxTiJ/11E8gleeY8rJKN+/xc90ogjgkgNKid8Z6UvX1rTaskmqPsq
         rxijrY31q4BW3Wo9Wqgg86afTkd/F89Es0dXGTgqOKJluRFkDX7nOtaH4fYyNu2dw/P8
         lAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g/nqsGSCHKloMIgPNixbOCkctkUj9nB1nJ1CL7OwKos=;
        b=rt3lpzvt0cpkbQJjuk1Hijy47w79RRbCL71wz6Pkewa4vcaqkpn4W9E7GVhJ30ZUCL
         4ZezbkC3+wi5gd3Xy48C00+BwXB6mv4WDpWnjc7335PMWoztcNwp29L+jJuc86zHi/Ky
         pKM+zK7TXMX7Bk4j6osP0vuSQzId4BIgdbA+r/9+axqZzx9wDx1Jk9JkwCynU8x6xNmj
         8scrpiu4Um/hcCgXC8/kDtzL+5sm2dr50/ovo3eiJOW7o5CArH9n4lTNzMKvFJQEsTrO
         yrx+dx3VhY6L+sSWwgasfspbMobd49sFy0xsZCPCwUyMxmMLuCUv7hKgDgsxgkhJgqIY
         u5Yw==
X-Gm-Message-State: AOAM531NbR3emvMBZYca+xk1KYygllJ7PUDyiDrbrgApyLjwH3rSfetX
        94tsdC1ZyMBWQj6OO2KNNgc=
X-Google-Smtp-Source: ABdhPJxTHKMLwkJmODZypx7V0cr+hYWEtEwzYAkpUb6nDRK+6QWtHh9M5uzMZRIhFT6lE8YZ8H3Avw==
X-Received: by 2002:a92:99d5:: with SMTP id t82mr490197ilk.251.1604029924695;
        Thu, 29 Oct 2020 20:52:04 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 192sm4806852ilc.31.2020.10.29.20.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 20:52:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5E22527C005C;
        Thu, 29 Oct 2020 23:52:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 29 Oct 2020 23:52:02 -0400
X-ME-Sender: <xms:4Y2bXzXe0P7SfTA-6d5cAu0qZgsPeWtwkqQKdsLhmjxTF8GuC-6ISg>
    <xme:4Y2bX7lWZD0ia4gfTC3buyTZF0_8drVHoWh6e0Jpx09jypGwjk2ZDEDT-TZEZGgKf
    OyentVICjFTZEyHTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepudeijedrvddvtddrvddruddvieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:4Y2bX_Z6j6Gv8In1P6YI4q6nhgvzT29eOzyNc1TA-3zUAT9b0zgjiA>
    <xmx:4Y2bX-XKO6bHN1L5faD6DPw2KakUWANZRiU4u3fs7CNDVnemi1XAkg>
    <xmx:4Y2bX9nlHl2bW5oHnKTnQdsPT7LKUWowW06BWmsJg3BRyuCRZbApPQ>
    <xmx:4o2bXwtX-9nxzXMm28d7PCwimECTR9oOrwAdz0XXZYBzw-YEUic1hA>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1444C3280063;
        Thu, 29 Oct 2020 23:52:01 -0400 (EDT)
Date:   Fri, 30 Oct 2020 11:51:18 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        Qian Cai <cai@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [tip: locking/core] lockdep: Fix usage_traceoverflow
Message-ID: <20201030035118.GB855403@boqun-archlinux>
References: <160208761332.7002.17400661713288945222.tip-bot2@tip-bot2>
 <160379817513.29534.880306651053124370@build.alporthouse.com>
 <20201027115955.GA2611@hirez.programming.kicks-ass.net>
 <20201027123056.GE2651@hirez.programming.kicks-ass.net>
 <160380535006.10461.1259632375207276085@build.alporthouse.com>
 <20201027154533.GB2611@hirez.programming.kicks-ass.net>
 <160381649396.10461.15013696719989662769@build.alporthouse.com>
 <160390684819.31966.12048967113267928793@build.alporthouse.com>
 <20201028194208.GF2628@hirez.programming.kicks-ass.net>
 <20201028195910.GI2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028195910.GI2651@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi Peter,

On Wed, Oct 28, 2020 at 08:59:10PM +0100, Peter Zijlstra wrote:
> On Wed, Oct 28, 2020 at 08:42:09PM +0100, Peter Zijlstra wrote:
> > On Wed, Oct 28, 2020 at 05:40:48PM +0000, Chris Wilson wrote:
> > > Quoting Chris Wilson (2020-10-27 16:34:53)
> > > > Quoting Peter Zijlstra (2020-10-27 15:45:33)
> > > > > On Tue, Oct 27, 2020 at 01:29:10PM +0000, Chris Wilson wrote:
> > > > > 
> > > > > > <4> [304.908891] hm#2, depth: 6 [6], 3425cfea6ff31f7f != 547d92e9ec2ab9af
> > > > > > <4> [304.908897] WARNING: CPU: 0 PID: 5658 at kernel/locking/lockdep.c:3679 check_chain_key+0x1a4/0x1f0
> > > > > 
> > > > > Urgh, I don't think I've _ever_ seen that warning trigger.
> > > > > 
> > > > > The comments that go with it suggest memory corruption is the most
> > > > > likely trigger of it. Is it easy to trigger?
> > > > 
> > > > For the automated CI, yes, the few machines that run that particular HW
> > > > test seem to hit it regularly. I have not yet reproduced it for myself.
> > > > I thought it looked like something kasan would provide some insight for
> > > > and we should get a kasan run through CI over the w/e. I suspect we've
> > > > feed in some garbage and called it a lock.
> > > 
> > > I tracked it down to a second invocation of lock_acquire_shared_recursive()
> > > intermingled with some other regular mutexes (in this case ww_mutex).
> > > 
> > > We hit this path in validate_chain():
> > > 	/*
> > > 	 * Mark recursive read, as we jump over it when
> > > 	 * building dependencies (just like we jump over
> > > 	 * trylock entries):
> > > 	 */
> > > 	if (ret == 2)
> > > 		hlock->read = 2;
> > > 
> > > and that is modifying hlock_id() and so the chain-key, after it has
> > > already been computed.
> > 
> > Ooh, interesting.. I'll have to go look at this in the morning, brain is
> > fried already. Thanks for digging into it.
> 

Sorry for the late response.

> So that's commit f611e8cf98ec ("lockdep: Take read/write status in
> consideration when generate chainkey") that did that.
> 

Yeah, I think that's related, howver ...

> So validate_chain() requires the new chain_key, but can change ->read
> which then invalidates the chain_key we just calculated.
> 
> This happens when check_deadlock() returns 2, which only happens when:
> 
>   - next->read == 2 && ... ; however @hext is our @hlock, so that's
>     pointless
> 

I don't think we should return 2 (earlier) in this case anymore. Because
now we have recursive read deadlock detection, it's safe to add dep:
"prev -> next" in the dependency graph. I think we can just continue in
this case. Actually I think this is something I'm missing in my
recursive read detection patchset :-/

>   - when there's a nest_lock involved ; ww_mutex uses that !!!
> 

That leaves check_deadlock() return 2 only if hlock is a nest_lock, and
...

> I suppose something like the below _might_ just do it, but I haven't
> compiled it, and like said, my brain is fried.
> 
> Boqun, could you have a look, you're a few timezones ahead of us so your
> morning is earlier ;-)
> 
> ---
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 3e99dfef8408..3caf63532bc2 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3556,7 +3556,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
>  
>  static int validate_chain(struct task_struct *curr,
>  			  struct held_lock *hlock,
> -			  int chain_head, u64 chain_key)
> +			  int chain_head, u64 *chain_key)
>  {
>  	/*
>  	 * Trylock needs to maintain the stack of held locks, but it
> @@ -3568,6 +3568,7 @@ static int validate_chain(struct task_struct *curr,
>  	 * (If lookup_chain_cache_add() return with 1 it acquires
>  	 * graph_lock for us)
>  	 */
> +again:
>  	if (!hlock->trylock && hlock->check &&
>  	    lookup_chain_cache_add(curr, hlock, chain_key)) {
>  		/*
> @@ -3597,8 +3598,12 @@ static int validate_chain(struct task_struct *curr,
>  		 * building dependencies (just like we jump over
>  		 * trylock entries):
>  		 */
> -		if (ret == 2)
> +		if (ret == 2) {
>  			hlock->read = 2;
> +			*chain_key = iterate_chain_key(hlock->prev_chain_key, hlock_id(hlock));

If "ret == 2" means hlock is a a nest_lock, than we don't need the
"->read = 2" trick here and we don't need to update chain_key either.
We used to have this "->read = 2" only because we want to skip the
dependency adding step afterwards. So how about the following:

It survived a lockdep selftest at boot time.

Regards,
Boqun

----------------------------->8
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3e99dfef8408..b23ca6196561 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2765,7 +2765,7 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
  * (Note that this has to be done separately, because the graph cannot
  * detect such classes of deadlocks.)
  *
- * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
+ * Returns: 0 on deadlock detected, 1 on OK, 2 on nest_lock
  */
 static int
 check_deadlock(struct task_struct *curr, struct held_lock *next)
@@ -2788,7 +2788,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
 		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
 		 */
 		if ((next->read == 2) && prev->read)
-			return 2;
+			continue;
 
 		/*
 		 * We're holding the nest_lock, which serializes this lock's
@@ -3592,16 +3592,9 @@ static int validate_chain(struct task_struct *curr,
 
 		if (!ret)
 			return 0;
-		/*
-		 * Mark recursive read, as we jump over it when
-		 * building dependencies (just like we jump over
-		 * trylock entries):
-		 */
-		if (ret == 2)
-			hlock->read = 2;
 		/*
 		 * Add dependency only if this lock is not the head
-		 * of the chain, and if it's not a secondary read-lock:
+		 * of the chain, and if it's not a nest_lock:
 		 */
 		if (!chain_head && ret != 2) {
 			if (!check_prevs_add(curr, hlock))
