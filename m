Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36FC23E4AE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Aug 2020 01:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgHFXkm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 Aug 2020 19:40:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60862 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgHFXiq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:46 -0400
Date:   Thu, 06 Aug 2020 23:38:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDnsT3TJ0pTh+XRVejYB3KI1Qgf/MQI0koJ/p170YOo=;
        b=u2o2bFpgl59UEtQivvuwxnBUs1BaxrmsZR06PCS+dc+PhGJG3fLBnS668MWgwN2tl+/rpK
        V7Mz9uikoQ91LkRg+FBhr3Ojd8h/JgVsrArACy9BEZZktqVLyhxZs7sSSju8QOUoGGfYLv
        QL3UobstpTRAZONRKTEl94pot5sTmLfzhQkW6aGfgOvIXIvL5NpiCmz2DSv17DokAk1ve4
        tUdoFjIzDfZ0TjYdppiDzvqDYPT8XYwlr1S+FV/mfJWzrZpvoCcT+dsvPcC5+AyDB5hLk6
        DGmBq8VtqClHkr0CrCoWQdX6iVjvDHAKuEAjojciBZH3VfqjIs2R6KPMozcY6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDnsT3TJ0pTh+XRVejYB3KI1Qgf/MQI0koJ/p170YOo=;
        b=QlyUNEEjeuQytYkrVVhJT/uqHRdVsWi3R62p8liKGbsRCV8CpLL6pPFzNCijrw05I71/nV
        elUJjco286wufpDw==
From:   "tip-bot2 for Pingfan Liu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/purgatory: Don't generate debug info for purgatory.ro
Cc:     Pingfan Liu <kernelfans@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dave Young <dyoung@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1596433788-3784-1-git-send-email-kernelfans@gmail.com>
References: <1596433788-3784-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Message-ID: <159675712366.3192.8333257283870120334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     52416ffcf823ee11aa19792715664ab94757f111
Gitweb:        https://git.kernel.org/tip/52416ffcf823ee11aa19792715664ab94757f111
Author:        Pingfan Liu <kernelfans@gmail.com>
AuthorDate:    Mon, 03 Aug 2020 13:49:48 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 07 Aug 2020 01:32:00 +02:00

x86/purgatory: Don't generate debug info for purgatory.ro

Purgatory.ro is a standalone binary that is not linked against the rest of
the kernel.  Its image is copied into an array that is linked to the
kernel, and from there kexec relocates it wherever it desires.

Unlike the debug info for vmlinux, which can be used for analyzing crash
such info is useless in purgatory.ro. And discarding them can save about
200K space.

 Original:
   259080  kexec-purgatory.o
 Stripped debug info:
    29152  kexec-purgatory.o

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Dave Young <dyoung@redhat.com>
Link: https://lore.kernel.org/r/1596433788-3784-1-git-send-email-kernelfans@gmail.com
---
 arch/x86/purgatory/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 088bd76..d24b43a 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -32,7 +32,7 @@ KCOV_INSTRUMENT := n
 # make up the standalone purgatory.ro
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
-PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
+PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
 
@@ -64,6 +64,9 @@ CFLAGS_sha256.o			+= $(PURGATORY_CFLAGS)
 CFLAGS_REMOVE_string.o		+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
 
+AFLAGS_REMOVE_setup-x86_$(BITS).o	+= -Wa,-gdwarf-2
+AFLAGS_REMOVE_entry64.o			+= -Wa,-gdwarf-2
+
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
