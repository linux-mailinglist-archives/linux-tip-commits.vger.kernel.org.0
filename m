Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B944A41385A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 19:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhIURgM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 13:36:12 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:43636 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhIURdK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 13:33:10 -0400
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 230C57A0212;
        Tue, 21 Sep 2021 19:31:40 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip: x86/core] x86/iopl: Fake iopl(3) CLI/STI usage
Date:   Tue, 21 Sep 2021 19:31:36 +0200
User-Agent: KMail/1.9.10
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
References: <20210918090641.GD5106@worktop.programming.kicks-ass.net> <202109211309.26518.linux@zary.sk> <YUnJe6rijGy6q1Cz@hirez.programming.kicks-ass.net>
In-Reply-To: <YUnJe6rijGy6q1Cz@hirez.programming.kicks-ass.net>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202109211931.37066.linux@zary.sk>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tuesday 21 September 2021 14:00:59 Peter Zijlstra wrote:
> On Tue, Sep 21, 2021 at 01:09:26PM +0200, Ondrej Zary wrote:
> > On Tuesday 21 September 2021, tip-bot2 for Peter Zijlstra wrote:
> > > The following commit has been merged into the x86/core branch of tip:
> > > 
> > > Commit-ID:     32e1ae626f295152d1fc9a3375214133cbe62878
> > > Gitweb:        https://git.kernel.org/tip/32e1ae626f295152d1fc9a3375214133cbe62878
> > > Author:        Peter Zijlstra <peterz@infradead.org>
> > > AuthorDate:    Fri, 17 Sep 2021 11:20:04 +02:00
> > > Committer:     Peter Zijlstra <peterz@infradead.org>
> > > CommitterDate: Sat, 18 Sep 2021 12:18:32 +02:00
> > > 
> > > x86/iopl: Fake iopl(3) CLI/STI usage
> > > 
> > > Since commit c8137ace5638 ("x86/iopl: Restrict iopl() permission
> > > scope") it's possible to emulate iopl(3) using ioperm(), except for
> > > the CLI/STI usage.
> > > 
> > > Userspace CLI/STI usage is very dubious (read broken), since any
> > > exception taken during that window can lead to rescheduling anyway (or
> > > worse). The IOPL(2) manpage even states that usage of CLI/STI is highly
> > > discouraged and might even crash the system.
> > > 
> > > Of course, that won't stop people and HP has the dubious honour of
> > > being the first vendor to be found using this in their hp-health
> > > package.
> > > 
> > > In order to enable this 'software' to still 'work', have the #GP treat
> > > the CLI/STI instructions as NOPs when iopl(3). Warn the user that
> > > their program is doing dubious things.
> > > 
> > > Fixes: a24ca9976843 ("x86/iopl: Remove legacy IOPL option")
> > > Reported-by: Ondrej Zary <linux@zary.sk>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > > Link: https://lkml.kernel.org/r/20210918090641.GD5106@worktop.programming.kicks-ass.net
> > 
> > Could this be backported to 5.10 kernel so it can get into the recently released Debian 11?
> 
> Thomas also asked about a stable tag, so I'll rebase and force-push
> these commits and add:
> 
> Cc: stable@kernel.org # v5.5+
> 
> to it.
> 

Thank you very much for great work.

-- 
Ondrej Zary
