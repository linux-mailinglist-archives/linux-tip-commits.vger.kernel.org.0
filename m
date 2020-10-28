Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEDF29D382
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Oct 2020 22:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgJ1VoU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Oct 2020 17:44:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60078 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgJ1VoU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Oct 2020 17:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RcoHc6ioxIJHRLjyoIAWbgcMWvY3wzGmR282L3Znkso=; b=DCpptmVv4mZATOp9w7gcazeapY
        d+U5ktRYCztpocpf/4LDVXTMeM7/7NzPH7i+LDPLZBLRDMJAP0wWyfr6ula8PZEnQsNzD7t6g/MOb
        DcfXxUPD+sVNkf8VpE0EJDWif5ejxViCBraLN4XvLUmKUuSS23ZCXc4S5VFPXiGqoVlbaD1/gzoSM
        w7DvDeQVVLM/sFvtbAKs2Qfa5DnUs34MnvyeFqH8bI2Zv4v1jKCthfSRMlars4sxtZoPNToXmKU3G
        H5kP9688TYmUmR+msBoc9DOl3vc8iJ2eXKojKbECifY92ewQQrarqd7NBuAiPiFiSE3/kPWk+wrht
        8tZ0xAQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXrKl-0002ac-T5; Wed, 28 Oct 2020 19:42:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49FA530018A;
        Wed, 28 Oct 2020 20:42:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0604F2C114CE2; Wed, 28 Oct 2020 20:42:09 +0100 (CET)
Date:   Wed, 28 Oct 2020 20:42:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        Qian Cai <cai@redhat.com>, x86 <x86@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [tip: locking/core] lockdep: Fix usage_traceoverflow
Message-ID: <20201028194208.GF2628@hirez.programming.kicks-ass.net>
References: <20200930094937.GE2651@hirez.programming.kicks-ass.net>
 <160208761332.7002.17400661713288945222.tip-bot2@tip-bot2>
 <160379817513.29534.880306651053124370@build.alporthouse.com>
 <20201027115955.GA2611@hirez.programming.kicks-ass.net>
 <20201027123056.GE2651@hirez.programming.kicks-ass.net>
 <160380535006.10461.1259632375207276085@build.alporthouse.com>
 <20201027154533.GB2611@hirez.programming.kicks-ass.net>
 <160381649396.10461.15013696719989662769@build.alporthouse.com>
 <160390684819.31966.12048967113267928793@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160390684819.31966.12048967113267928793@build.alporthouse.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 28, 2020 at 05:40:48PM +0000, Chris Wilson wrote:
> Quoting Chris Wilson (2020-10-27 16:34:53)
> > Quoting Peter Zijlstra (2020-10-27 15:45:33)
> > > On Tue, Oct 27, 2020 at 01:29:10PM +0000, Chris Wilson wrote:
> > > 
> > > > <4> [304.908891] hm#2, depth: 6 [6], 3425cfea6ff31f7f != 547d92e9ec2ab9af
> > > > <4> [304.908897] WARNING: CPU: 0 PID: 5658 at kernel/locking/lockdep.c:3679 check_chain_key+0x1a4/0x1f0
> > > 
> > > Urgh, I don't think I've _ever_ seen that warning trigger.
> > > 
> > > The comments that go with it suggest memory corruption is the most
> > > likely trigger of it. Is it easy to trigger?
> > 
> > For the automated CI, yes, the few machines that run that particular HW
> > test seem to hit it regularly. I have not yet reproduced it for myself.
> > I thought it looked like something kasan would provide some insight for
> > and we should get a kasan run through CI over the w/e. I suspect we've
> > feed in some garbage and called it a lock.
> 
> I tracked it down to a second invocation of lock_acquire_shared_recursive()
> intermingled with some other regular mutexes (in this case ww_mutex).
> 
> We hit this path in validate_chain():
> 	/*
> 	 * Mark recursive read, as we jump over it when
> 	 * building dependencies (just like we jump over
> 	 * trylock entries):
> 	 */
> 	if (ret == 2)
> 		hlock->read = 2;
> 
> and that is modifying hlock_id() and so the chain-key, after it has
> already been computed.

Ooh, interesting.. I'll have to go look at this in the morning, brain is
fried already. Thanks for digging into it.
