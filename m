Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1D52AA461
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 11:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgKGKSu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 7 Nov 2020 05:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgKGKSt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 7 Nov 2020 05:18:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF908C0613CF;
        Sat,  7 Nov 2020 02:18:48 -0800 (PST)
Date:   Sat, 07 Nov 2020 10:18:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604744326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=teApRVu24PqpjDz+xhtMmc0ALpIwkQx88SsyiT75wb8=;
        b=ZrDsXKHTXZr2FLI0PxijF5hnE5DebEEChg8mDjiTua5L25rSnS4Zxu5dHHnVTuHcIIGWba
        KANSqkgeg9k893LeEl4KntiHKXQ+JblDNF09J+3pDrFZymdG0BqHaPR33a7LZmLCxf++qp
        ux9DSqW4EvJakJnB+XnV3i0p8QDKyykYb9JFvr4utYv50YbhLl5B4TOV6NMCjp8YKixfWQ
        3vMGa22QLsPMXzOxkAz8G2QIfGueuUNU+p4j3W9q9Wt84kOSl1Hf6y4N0r1HteW/v//rNL
        euGXpiygujMO4G2VHc7wiStr+uySaBllxhOoWjjT+EOz72Zwc6C3CIJgZ87MwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604744326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=teApRVu24PqpjDz+xhtMmc0ALpIwkQx88SsyiT75wb8=;
        b=a/HIw4FNSgW85MTetH088N6yRG7W2r8qGX2+NlM4eIvOqnP+J6AUUNhLWyCTjflaWGd4oa
        o+Z4fvvMk59m4YDg==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform/uv: Remove spaces from OEM IDs
Cc:     Mike Travis <mike.travis@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201105222741.157029-3-mike.travis@hpe.com>
References: <20201105222741.157029-3-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160474432512.397.9918454290577687435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1aee505e0171fc38fd5ed70c7f0dcbb7398c759f
Gitweb:        https://git.kernel.org/tip/1aee505e0171fc38fd5ed70c7f0dcbb7398c759f
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Thu, 05 Nov 2020 16:27:40 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 07 Nov 2020 11:17:39 +01:00

x86/platform/uv: Remove spaces from OEM IDs

Testing shows that trailing spaces caused problems with the OEM_ID and
the OEM_TABLE_ID.  One being that the OEM_ID would not string compare
correctly.  Another the OEM_ID and OEM_TABLE_ID would be concatenated
in the printout.  Remove any trailing spaces.

Fixes: 1e61f5a95f191 ("Add and decode Arch Type in UVsystab")
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201105222741.157029-3-mike.travis@hpe.com


---
 arch/x86/kernel/apic/x2apic_uv_x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index a579479..0f848d6 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -290,6 +290,9 @@ static void __init uv_stringify(int len, char *to, char *from)
 {
 	/* Relies on 'to' being NULL chars so result will be NULL terminated */
 	strncpy(to, from, len-1);
+
+	/* Trim trailing spaces */
+	(void)strim(to);
 }
 
 /* Find UV arch type entry in UVsystab */
