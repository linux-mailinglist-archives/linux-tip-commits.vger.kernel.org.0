Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98C541326E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhIULUm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 07:20:42 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:38400 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhIULUl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 07:20:41 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2021 07:20:41 EDT
Received: from [192.168.1.3] (ns.gsystem.sk [62.176.172.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 733C07A0222;
        Tue, 21 Sep 2021 13:09:29 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/core] x86/iopl: Fake iopl(3) CLI/STI usage
Date:   Tue, 21 Sep 2021 13:09:26 +0200
User-Agent: KMail/1.9.10
Cc:     linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
References: <20210918090641.GD5106@worktop.programming.kicks-ass.net> <163220928593.25758.16098239507716851071.tip-bot2@tip-bot2>
In-Reply-To: <163220928593.25758.16098239507716851071.tip-bot2@tip-bot2>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202109211309.26518.linux@zary.sk>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tuesday 21 September 2021, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the x86/core branch of tip:
> 
> Commit-ID:     32e1ae626f295152d1fc9a3375214133cbe62878
> Gitweb:        https://git.kernel.org/tip/32e1ae626f295152d1fc9a3375214133cbe62878
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Fri, 17 Sep 2021 11:20:04 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Sat, 18 Sep 2021 12:18:32 +02:00
> 
> x86/iopl: Fake iopl(3) CLI/STI usage
> 
> Since commit c8137ace5638 ("x86/iopl: Restrict iopl() permission
> scope") it's possible to emulate iopl(3) using ioperm(), except for
> the CLI/STI usage.
> 
> Userspace CLI/STI usage is very dubious (read broken), since any
> exception taken during that window can lead to rescheduling anyway (or
> worse). The IOPL(2) manpage even states that usage of CLI/STI is highly
> discouraged and might even crash the system.
> 
> Of course, that won't stop people and HP has the dubious honour of
> being the first vendor to be found using this in their hp-health
> package.
> 
> In order to enable this 'software' to still 'work', have the #GP treat
> the CLI/STI instructions as NOPs when iopl(3). Warn the user that
> their program is doing dubious things.
> 
> Fixes: a24ca9976843 ("x86/iopl: Remove legacy IOPL option")
> Reported-by: Ondrej Zary <linux@zary.sk>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/20210918090641.GD5106@worktop.programming.kicks-ass.net

Could this be backported to 5.10 kernel so it can get into the recently released Debian 11?

-- 
Ondrej Zary
