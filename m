Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57129B95C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Oct 2020 17:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1802393AbgJ0PsF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 11:48:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51744 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1802140AbgJ0Ppp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 11:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vS0WQyA1FoopoJORMaYRyN4NqXEhBztCAPdnx7wzKRQ=; b=V4L7qO2R2JS6pfVWkQymVaWMwj
        RmjAu/+KnCywtjZeZK9NVh+x0yEmTW0fFmGJ/vI4GFgqyf1KSr4f4DnxLB6XcnZRVvcFTZBE1pU2K
        PkpcGgFuFuA50BHrE/3PQijXYUPUEo65svNy/X64ptCQF1jsNXjZFOGiJpJo0P34Ms67tBGRFzanp
        8qhK0j5vR3gFi3+q5LWdy7qxPPxKMOxw9OuGi9x3Uh3hnFTPSIBHGlcTteCxRDjNRr4QqtZuBgLyt
        TlcrZhtGUH8hkI1+fqVOmwRdJxetpEJy1Y//hMblbW0QhMYESRv5WcJcwRT6M+E5U/IcQq39HAh3i
        VVMxcvKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXRAH-0004XO-B2; Tue, 27 Oct 2020 15:45:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D08993060F2;
        Tue, 27 Oct 2020 16:45:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7876203CF3A9; Tue, 27 Oct 2020 16:45:33 +0100 (CET)
Date:   Tue, 27 Oct 2020 16:45:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        Qian Cai <cai@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [tip: locking/core] lockdep: Fix usage_traceoverflow
Message-ID: <20201027154533.GB2611@hirez.programming.kicks-ass.net>
References: <20200930094937.GE2651@hirez.programming.kicks-ass.net>
 <160208761332.7002.17400661713288945222.tip-bot2@tip-bot2>
 <160379817513.29534.880306651053124370@build.alporthouse.com>
 <20201027115955.GA2611@hirez.programming.kicks-ass.net>
 <20201027123056.GE2651@hirez.programming.kicks-ass.net>
 <160380535006.10461.1259632375207276085@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160380535006.10461.1259632375207276085@build.alporthouse.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Oct 27, 2020 at 01:29:10PM +0000, Chris Wilson wrote:

> <4> [304.908891] hm#2, depth: 6 [6], 3425cfea6ff31f7f != 547d92e9ec2ab9af
> <4> [304.908897] WARNING: CPU: 0 PID: 5658 at kernel/locking/lockdep.c:3679 check_chain_key+0x1a4/0x1f0

Urgh, I don't think I've _ever_ seen that warning trigger.

The comments that go with it suggest memory corruption is the most
likely trigger of it. Is it easy to trigger?
