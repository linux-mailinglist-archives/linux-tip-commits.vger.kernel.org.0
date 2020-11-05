Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8058D2A776F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Nov 2020 07:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgKEG0v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Nov 2020 01:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKEG0u (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Nov 2020 01:26:50 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA626C0613CF;
        Wed,  4 Nov 2020 22:26:50 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id e16so424185ile.0;
        Wed, 04 Nov 2020 22:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yMoN9CcjZEMdnHjc3tRnJqGOy/c8lcc1MIMaRCWncns=;
        b=LzFVxVueBrAwRyToTYXZTlRIqLx/FKPciZUesEFloynOLvYj2Utihj8mkG2bdlMwYE
         7OkD+pdqnv4WADeop0/QuUrB7gEN452rRBFXQygGHw5cx7USeiYSzZAm2uc5pzXtOyF4
         ZcjFkkZVqkfuW6TlJAOWSHl5nZ5CMdX+/jeIlnF9JZtjO+lEdaaZapU/UColtWcMg6of
         buM1u4KLaaMe2xDfgnabRQa9xVerKZ2fufzYVWSmeTpCF6Jy6Oa0VXm5BcsJHepoe37Y
         EuajQ5kFH3Y4YLvv9lFMV1u+HpVLRN2uf7FB04Unkm6ALDCZzudBjdh7NKwV8Wdu6dDJ
         SxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yMoN9CcjZEMdnHjc3tRnJqGOy/c8lcc1MIMaRCWncns=;
        b=r9W4OIBbjhR55T2ihjVsODeC1UFsDnkGucomFYphiQcXlQTNbWHbfIKLvVfPOBOY8n
         vXJpWNo2I9KrKhgYCwfBCBV38diJkA8PYDZntfiCHNPq6n/ol9OeStZB2rNRd85U/Zi9
         Ef61pnobk1HttrYnCDmFvXON6B9tidbSvcxoFGwUriEfrB2cqRL8IGhUGgJL8xrOTzE4
         rE7B0/+SratfPZMlmwJoc6hKiWihzz7WNnAoUDF/o/fTISO7nSwQIQF5yAzNJHliCxB4
         H+QSpii7H3InWrYGcYo64h5erWO5KEplgdtmTpQ8Jhvf2Yn0hyc0gMss1KPd+S1WNxc8
         R67Q==
X-Gm-Message-State: AOAM532lcMNyvimACfT/t2ugWTJhodlqUfX57ZfqXaZZKJFA+lYVVRa2
        x0b5ceKlUlPYZJRTOV4g2A8=
X-Google-Smtp-Source: ABdhPJwyC8qD92h+tTY7bFIGdN82wnTZnzzqRSOcZeI1EH3iByKz4yPbcLDK2LAK/D+1phBpyW+ALg==
X-Received: by 2002:a92:4a02:: with SMTP id m2mr807376ilf.51.1604557610181;
        Wed, 04 Nov 2020 22:26:50 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id b1sm480296iog.14.2020.11.04.22.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2020 22:26:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id D18D827C0054;
        Thu,  5 Nov 2020 01:26:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 01:26:48 -0500
X-ME-Sender: <xms:KJujX4DIzpk_AC4HT9oI1Wn6qLxG_3nyuq_IqUa3Uhary0QFHsk3jQ>
    <xme:KJujX6h6JGOtV50pM3mCJM3XoSVI6ZplQvqbtQDkVKy_8KkhFEjKV3uJb2jAu88ss
    mcnU3WGW5PtumGqkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeduieejrddvvddtrddvrdduvdeinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:KJujX7mB-7Zgvr5esBWCZQRRsCJZ8BG13d3oZhP2VBfdiDZ2wQ7C7g>
    <xmx:KJujX-zdESlD3OEGsFBPiNzeZ2PtTmTQmAK3ufZfhE9Lg7lPOffhcA>
    <xmx:KJujX9RJ0QMvLNX5SKkzhG_LHm22zazE9JTXjPzgHUoqhp3j3PUFvg>
    <xmx:KJujX2Kr8oWQ2aOB7N9C0uO5LY8atJhA8ZCfuO9Rbt6ce-Lsr1Dtvw>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 190C1328038D;
        Thu,  5 Nov 2020 01:26:48 -0500 (EST)
Date:   Thu, 5 Nov 2020 14:25:50 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Qian Cai <cai@redhat.com>, Chris Wilson <chris@chris-wilson.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] lockdep: Avoid to modify chain keys in
 validate_chain()
Message-ID: <20201105062550.GC2748545@boqun-archlinux>
References: <20201030093806.GA2628@hirez.programming.kicks-ass.net>
 <20201102053743.450459-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102053743.450459-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi Chris,

Could you try this to see if it fixes the problem? Thanks!

Regards,
Boqun

On Mon, Nov 02, 2020 at 01:37:41PM +0800, Boqun Feng wrote:
> Chris Wilson reported a problem spotted by check_chain_key(): a chain
> key got changed in validate_chain() because we modify the ->read in
> validate_chain() to skip checks for dependency adding, and ->read is
> taken into calculation for chain key since commit f611e8cf98ec
> ("lockdep: Take read/write status in consideration when generate
> chainkey").
> 
> Fix this by avoiding to modify ->read in validate_chain() based on two
> facts: a) since we now support recursive read lock detection, there is
> no need to skip checks for dependency adding for recursive readers, b)
> since we have a), there is only one case left (nest_lock) where we want
> to skip checks in validate_chain(), we simply remove the modification
> for ->read and rely on the return value of check_deadlock() to skip the
> dependency adding.
> 
> Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
> Peter,
> 
> I managed to get a reproducer for the problem Chris reported, please see
> patch #2. With this patch, that problem gets fixed.
> 
> This small patchset is based on your locking/core, patch #2 actually
> relies on your "s/raw_spin/spin" changes, thanks for taking care of that
> ;-)
> 
> Regards,
> Boqun
> 
>  kernel/locking/lockdep.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 3e99dfef8408..a294326fd998 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2765,7 +2765,9 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
>   * (Note that this has to be done separately, because the graph cannot
>   * detect such classes of deadlocks.)
>   *
> - * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
> + * Returns: 0 on deadlock detected, 1 on OK, 2 if another lock with the same
> + * lock class is held but nest_lock is also held, i.e. we rely on the
> + * nest_lock to avoid the deadlock.
>   */
>  static int
>  check_deadlock(struct task_struct *curr, struct held_lock *next)
> @@ -2788,7 +2790,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
>  		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
>  		 */
>  		if ((next->read == 2) && prev->read)
> -			return 2;
> +			continue;
>  
>  		/*
>  		 * We're holding the nest_lock, which serializes this lock's
> @@ -3592,16 +3594,13 @@ static int validate_chain(struct task_struct *curr,
>  
>  		if (!ret)
>  			return 0;
> -		/*
> -		 * Mark recursive read, as we jump over it when
> -		 * building dependencies (just like we jump over
> -		 * trylock entries):
> -		 */
> -		if (ret == 2)
> -			hlock->read = 2;
>  		/*
>  		 * Add dependency only if this lock is not the head
> -		 * of the chain, and if it's not a secondary read-lock:
> +		 * of the chain, and if the new lock introduces no more
> +		 * lock dependency (because we already hold a lock with the
> +		 * same lock class) nor deadlock (because the nest_lock
> +		 * serializes nesting locks), see the comments for
> +		 * check_deadlock().
>  		 */
>  		if (!chain_head && ret != 2) {
>  			if (!check_prevs_add(curr, hlock))
> -- 
> 2.28.0
> 
