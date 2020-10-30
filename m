Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DA62A01E4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Oct 2020 10:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgJ3J4G (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 30 Oct 2020 05:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3J4G (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 30 Oct 2020 05:56:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13062C0613CF;
        Fri, 30 Oct 2020 02:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qtz8Xdgy6c70WedOeRlARJGaO0g6QyAZ2rh9hmruGO4=; b=UDlYvcPUqyS+VYfBYR/W9yycJn
        r14d/1xIMpRnIpiwiYr6C0aulO4DoR7t2uQovdcG7PmkvD2b711DZd5ipIuNgLOT+wzBlM3qiHzYa
        Yk8B7sffT6IjsQU2//8KkNfQWyYj/J6uOsl4vgedTPMjRwMiHINitI7qhnpt9WW3BuzUmJpDtX9C9
        Y1JPiazNrVkgL0+BKMeTCpzXo2JfFrEF5jmrIaCiA89HuHnCeDm9I27MU2gM99Mc2btxg08MaueAx
        mfUTfFtOKzB7tL37pkxb+f8eCDpdK3MFd0xPnZBeDDFEW+4ims/j8a9iIRMmNT3DIOTSxysRJehXB
        KmX3dxxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYR8Y-0005wo-HD; Fri, 30 Oct 2020 09:55:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8232D3012C3;
        Fri, 30 Oct 2020 10:55:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E721203C534D; Fri, 30 Oct 2020 10:55:54 +0100 (CET)
Date:   Fri, 30 Oct 2020 10:55:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        Qian Cai <cai@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [tip: locking/core] lockdep: Fix usage_traceoverflow
Message-ID: <20201030095554.GL2651@hirez.programming.kicks-ass.net>
References: <20201027115955.GA2611@hirez.programming.kicks-ass.net>
 <20201027123056.GE2651@hirez.programming.kicks-ass.net>
 <160380535006.10461.1259632375207276085@build.alporthouse.com>
 <20201027154533.GB2611@hirez.programming.kicks-ass.net>
 <160381649396.10461.15013696719989662769@build.alporthouse.com>
 <160390684819.31966.12048967113267928793@build.alporthouse.com>
 <20201028194208.GF2628@hirez.programming.kicks-ass.net>
 <20201028195910.GI2651@hirez.programming.kicks-ass.net>
 <20201030035118.GB855403@boqun-archlinux>
 <20201030093806.GA2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030093806.GA2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Oct 30, 2020 at 10:38:06AM +0100, Peter Zijlstra wrote:
> >  		if (!chain_head && ret != 2) {
> >  			if (!check_prevs_add(curr, hlock))
> 
> I'm not entirely sure that doesn't still trigger the problem. Consider
> @chain_head := true.

Urgh, clearly my brain really isn't working well. Ignore that.
