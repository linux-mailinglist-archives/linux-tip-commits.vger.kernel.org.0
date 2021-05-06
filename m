Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC9E375382
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 14:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhEFMPN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 08:15:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhEFMPG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 08:15:06 -0400
Date:   Thu, 06 May 2021 12:14:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620303248;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDAXsfq9HSSrj7Fsfp5QdM2dh8CR3kCK3AiBYsmbdoI=;
        b=Yz3snebOTO0bv4Zrds0SM24Qnt8hdSZHJ41BGHLpg09bfWA9tJgw2nrqqDUnbwWWry1GAt
        usxuJfO2Y/1gSL8RBDBx5gFyBdBmvwLDhDZZOUM1VXybmg+VSITgzsXnQ69Ky0upFIpiSI
        kL8LUyBkGrSPP7R4wL9hreKdXuOV9PjoxNyoTeiYXhXE7NwF147bqv0OBhkDN+cfFcaEHv
        ZRAZxGzCoVmBPTaXcsZDaLqRrZf/HgReD//0LfiXEptzW8BxaXBmyKl/oonQXPWRlU1ZLf
        ZvLVAakGwkIFU5ivaEPsyCk6BNXBEz8hAhW+CIAkVWyMg9dklTIwDcWIcMFF1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620303248;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDAXsfq9HSSrj7Fsfp5QdM2dh8CR3kCK3AiBYsmbdoI=;
        b=tDD5LhPj/Si1vtesDOash4/kKE3j8vg7VO5tDfL/Mml3jkA5CB5zt9bvz6CwruKC6U4T7s
        V4odGC+xYcY0M+AQ==
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix init const confusion
Cc:     Andi Kleen <andi@firstfloor.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210425211229.3157674-1-ak@linux.intel.com>
References: <20210425211229.3157674-1-ak@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162030324755.29796.4163196088277383202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4029b9706d53e5e8db2e1cee6ecd75e60b62cd09
Gitweb:        https://git.kernel.org/tip/4029b9706d53e5e8db2e1cee6ecd75e60b62cd09
Author:        Andi Kleen <andi@firstfloor.org>
AuthorDate:    Sun, 25 Apr 2021 14:12:29 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 05 May 2021 21:50:14 +02:00

x86/resctrl: Fix init const confusion

const variable must be initconst, not initdata.

Signed-off-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210425211229.3157674-1-ak@linux.intel.com

---
 arch/x86/kernel/cpu/resctrl/monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index dbeaa84..f07c10b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -84,7 +84,7 @@ unsigned int resctrl_cqm_threshold;
 static const struct mbm_correction_factor_table {
 	u32 rmidthreshold;
 	u64 cf;
-} mbm_cf_table[] __initdata = {
+} mbm_cf_table[] __initconst = {
 	{7,	CF(1.000000)},
 	{15,	CF(1.000000)},
 	{15,	CF(0.969650)},
