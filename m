Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A2329EB77
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgJ2MPw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgJ2MPu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2DEC0613CF;
        Thu, 29 Oct 2020 05:15:50 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:15:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IliiBp8Fi5ZlqH7oES0Cz/sfPbAGKKM+77cKPA0BrhI=;
        b=IB91JZvCJJ7PbhvBVcPd69aReJJd/Be3vd6GP+KLaTTO8IPOOFTdoGmgi/0JkQiHgt5Y/9
        dFZMBgWW8FD1qDVAzZMKnodTxIOmZ2vlD+W4yQPyGRXi1Z4UWUyWJYkqWjj/Yws/0TI6ic
        VvGl2qa+tBlC88m4J0f9Hv7mda2AE5Mg3Y2rVYlAwToEOJxDusj9IDu0Q+yjUZ7N8L8JUv
        eUuW1Gf0ZKbij8XvfFzng/H6b/SmRqw418ANupZebvGMFkvEzvw5prCBfGCCOd5FwN3q4B
        /UQrbThFg8yE4K3h6c3C/xEj+o4VoK9MY7FDcr/Dv9J2fwQIm/hbX6j7kzZhNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IliiBp8Fi5ZlqH7oES0Cz/sfPbAGKKM+77cKPA0BrhI=;
        b=8vQ/fJUJLEnXhet4+vvxdaOG6Ypwq2P24bEmRnmwpRY08Ffuf9SZ678NhU6ONkgPyfPFOn
        0itr6VtXe9lmLOBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/uv: Fix inconsistent destination mode
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-4-dwmw2@infradead.org>
References: <20201024213535.443185-4-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374823.397.6297137923105641650.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     93b7a3d6a1f0f159d390959de7a1b9ad863d6b26
Gitweb:        https://git.kernel.org/tip/93b7a3d6a1f0f159d390959de7a1b9ad863d6b26
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:24 +01:00

x86/apic/uv: Fix inconsistent destination mode

The UV x2apic is strictly using physical destination mode, but
apic::dest_logical is initialized with APIC_DEST_LOGICAL.

This does not matter much because UV does not use any of the generic
functions which use apic::dest_logical, but is still inconsistent.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-4-dwmw2@infradead.org

---
 arch/x86/kernel/apic/x2apic_uv_x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 714233c..9ade9e6 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -811,7 +811,7 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.irq_dest_mode			= 0, /* Physical */
 
 	.disable_esr			= 0,
-	.dest_logical			= APIC_DEST_LOGICAL,
+	.dest_logical			= APIC_DEST_PHYSICAL,
 	.check_apicid_used		= NULL,
 
 	.init_apic_ldr			= uv_init_apic_ldr,
