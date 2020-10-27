Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB0829BD68
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Oct 2020 17:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1800102AbgJ0Qg3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 12:36:29 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:58585 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1810239AbgJ0QfO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 12:35:14 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 22819579-1500050 
        for multiple; Tue, 27 Oct 2020 16:34:57 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201027154533.GB2611@hirez.programming.kicks-ass.net>
References: <20200930094937.GE2651@hirez.programming.kicks-ass.net> <160208761332.7002.17400661713288945222.tip-bot2@tip-bot2> <160379817513.29534.880306651053124370@build.alporthouse.com> <20201027115955.GA2611@hirez.programming.kicks-ass.net> <20201027123056.GE2651@hirez.programming.kicks-ass.net> <160380535006.10461.1259632375207276085@build.alporthouse.com> <20201027154533.GB2611@hirez.programming.kicks-ass.net>
Subject: Re: [tip: locking/core] lockdep: Fix usage_traceoverflow
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        Qian Cai <cai@redhat.com>, x86 <x86@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Date:   Tue, 27 Oct 2020 16:34:53 +0000
Message-ID: <160381649396.10461.15013696719989662769@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Quoting Peter Zijlstra (2020-10-27 15:45:33)
> On Tue, Oct 27, 2020 at 01:29:10PM +0000, Chris Wilson wrote:
> 
> > <4> [304.908891] hm#2, depth: 6 [6], 3425cfea6ff31f7f != 547d92e9ec2ab9af
> > <4> [304.908897] WARNING: CPU: 0 PID: 5658 at kernel/locking/lockdep.c:3679 check_chain_key+0x1a4/0x1f0
> 
> Urgh, I don't think I've _ever_ seen that warning trigger.
> 
> The comments that go with it suggest memory corruption is the most
> likely trigger of it. Is it easy to trigger?

For the automated CI, yes, the few machines that run that particular HW
test seem to hit it regularly. I have not yet reproduced it for myself.
I thought it looked like something kasan would provide some insight for
and we should get a kasan run through CI over the w/e. I suspect we've
feed in some garbage and called it a lock.
-Chris
