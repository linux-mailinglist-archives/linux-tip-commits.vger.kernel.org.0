Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41A3A2536
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jun 2021 09:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhFJHWs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Jun 2021 03:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhFJHWs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Jun 2021 03:22:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699DDC061574;
        Thu, 10 Jun 2021 00:20:52 -0700 (PDT)
Date:   Thu, 10 Jun 2021 07:20:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623309651;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGZ3RpURnA8wRm2sDdPn6msKxg354ze+plbTik+8KKE=;
        b=lUYXGueLaREjMatNvglWhwlodsy6IGtdos35qw9uebq71R7WjlOQ92o8WDxNSZ4t5i0Ilu
        tdtMYi1J6lbrtxLysqAKgJAIkA9nzJizdiRRS8O0fhmn313at3jVcsgE+A78wnz0BoSChF
        bWJBGhcJxtbYQyKrRQ+5i66rbp8y90kRi5j8aoIJDc4BY28jwOZZJ5EP4dWqR1Fns96wOJ
        d66tzbXLtSH1yKkhz2KIkduHll+8Xue9QHBz+1oKKNPZtKf84oALl0tNZarNKSfdaXdz84
        p6zG+Zikc5b+QsnIf9Ke1x5Aoc/R4JOFbkNEkKBDg5lpUuEcnBwIZD7mvvNVMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623309651;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGZ3RpURnA8wRm2sDdPn6msKxg354ze+plbTik+8KKE=;
        b=TozlL5joE45pxEaFPckEMcCOdvx1eLjLLO0DIIawcjx8YlTMzhHpik2gwijPB+vdr69L3a
        y0A9gUVYmAxaMpDw==
From:   "tip-bot2 for CodyYao-oc" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] x86/nmi_watchdog: Fix old-style NMI watchdog
 regression on old Intel CPUs
Cc:     "CodyYao-oc" <CodyYao-oc@zhaoxin.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210607025335.9643-1-CodyYao-oc@zhaoxin.com>
References: <20210607025335.9643-1-CodyYao-oc@zhaoxin.com>
MIME-Version: 1.0
Message-ID: <162330965024.29796.13027483720549628002.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     89326c72c9b343da20a221a7234850e2e94161b7
Gitweb:        https://git.kernel.org/tip/89326c72c9b343da20a221a7234850e2e94161b7
Author:        CodyYao-oc <CodyYao-oc@zhaoxin.com>
AuthorDate:    Mon, 07 Jun 2021 10:53:35 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Jun 2021 09:19:00 +02:00

x86/nmi_watchdog: Fix old-style NMI watchdog regression on old Intel CPUs

The following commit:

   3a4ac121c2ca ("x86/perf: Add hardware performance events support for Zhaoxin CPU.")

Got the old-style NMI watchdog logic wrong and broke it for basically every
Intel CPU where it was active. Which is only truly old CPUs, so few people noticed.

On CPUs with perf events support we turn off the old-style NMI watchdog, so it
was pretty pointless to add the logic for X86_VENDOR_ZHAOXIN to begin with ... :-/

Anyway, the fix is to restore the old logic and add a 'break'.

[ mingo: Wrote a new changelog. ]

Fixes: 3a4ac121c2ca ("x86/perf: Add hardware performance events support for Zhaoxin CPU.")
Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210607025335.9643-1-CodyYao-oc@zhaoxin.com
---
 arch/x86/kernel/cpu/perfctr-watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/perfctr-watchdog.c b/arch/x86/kernel/cpu/perfctr-watchdog.c
index 3ef5868..7aecb2f 100644
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -63,7 +63,7 @@ static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
 		case 15:
 			return msr - MSR_P4_BPU_PERFCTR0;
 		}
-		fallthrough;
+		break;
 	case X86_VENDOR_ZHAOXIN:
 	case X86_VENDOR_CENTAUR:
 		return msr - MSR_ARCH_PERFMON_PERFCTR0;
@@ -96,7 +96,7 @@ static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
 		case 15:
 			return msr - MSR_P4_BSU_ESCR0;
 		}
-		fallthrough;
+		break;
 	case X86_VENDOR_ZHAOXIN:
 	case X86_VENDOR_CENTAUR:
 		return msr - MSR_ARCH_PERFMON_EVENTSEL0;
