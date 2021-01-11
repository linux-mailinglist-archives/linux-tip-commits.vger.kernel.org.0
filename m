Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424C02F1085
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Jan 2021 11:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbhAKKux (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 Jan 2021 05:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbhAKKux (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 Jan 2021 05:50:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92651C061794;
        Mon, 11 Jan 2021 02:50:12 -0800 (PST)
Date:   Mon, 11 Jan 2021 10:50:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610362210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SjG6NeQwMWLQyBvBb8aDaAh5iiJ+ZpsSSFk3gMHqIn8=;
        b=1xR7bKqLs4eEJWwEDdSo5Anta+6e+WzgdwJwsjSNQLg+icfOdxW2hUlvi3YazHcCtDpFYs
        pXK11OdX/UjaqwDhPvpBOZWkKD+EOJE3OBoRtvogLHcQFs0nPHGdDXSCahifV7IBDE0ZJz
        Fd8VGktBDpVJ3m2s0ocE6bwloFiyWvacY8RSn+J2lHlw3xZT3TKsm5TRvnfcfFRNP5wGcl
        lOqADayC/p+T/BUktK2qGiX2Jqceekd1RoZcyCCLC55r5/HcMO2OCP70xE6w5PRDfKAQj8
        Qe5kQcX/FDivB69DCHcieZP39tgRSbf36lsiKMWUw08cGDSGIlcQuo6LyKwF6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610362210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SjG6NeQwMWLQyBvBb8aDaAh5iiJ+ZpsSSFk3gMHqIn8=;
        b=C70oEVeMQrtKgC4Wkg3ceoR3B+mFGjc7zNJw24w/Y2VNeAQ4APKerRedIoqk8T7dqCVrPI
        8ACTlT2T3mn7h/Bw==
From:   "tip-bot2 for Tom Rix" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add printf attribute to log function
Cc:     Tom Rix <trix@redhat.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201221160009.3752017-1-trix@redhat.com>
References: <20201221160009.3752017-1-trix@redhat.com>
MIME-Version: 1.0
Message-ID: <161036220964.414.17560951659569378079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     3ff4ec0e281d0b234917e6e3033dd3067a5ea945
Gitweb:        https://git.kernel.org/tip/3ff4ec0e281d0b234917e6e3033dd3067a5ea945
Author:        Tom Rix <trix@redhat.com>
AuthorDate:    Mon, 21 Dec 2020 08:00:09 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 11 Jan 2021 11:20:36 +01:00

x86/resctrl: Add printf attribute to log function

Mark the function with the __printf attribute to allow the compiler to
more thoroughly typecheck its arguments against a format string with
-Wformat and similar flags.

 [ bp: Massage commit message. ]

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20201221160009.3752017-1-trix@redhat.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ee71c47..c4d320d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -572,6 +572,7 @@ union cpuid_0x10_x_edx {
 
 void rdt_last_cmd_clear(void);
 void rdt_last_cmd_puts(const char *s);
+__printf(1, 2)
 void rdt_last_cmd_printf(const char *fmt, ...);
 
 void rdt_ctrl_update(void *arg);
