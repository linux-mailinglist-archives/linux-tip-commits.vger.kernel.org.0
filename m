Return-Path: <linux-tip-commits+bounces-5338-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3465CAAD985
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC21981B84
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3552288C3;
	Wed,  7 May 2025 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uCrpx6Qz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZtcHqsoR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF4722540F;
	Wed,  7 May 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604680; cv=none; b=jNI4kDZj2/DCzjruVB+ujQOKeJy9WnveJx8HfwvIGuj3Dzv9Ysm3MA9LKq7cxTr+0avp1gm1Ka38aCGg1zBzyCdiD3kftnrDiDCof3Zm9Jcl7x8fPLHFS8dELQM+ChEzAvl7kMU45LEnz2gE6pXU0YjX5xL6vInkEgSD8DpKeoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604680; c=relaxed/simple;
	bh=n4Bs5fyjLjDOFBLbNqOtnjXKkPbscxCo6ffzKDOM2ro=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zxq4TwxLc7DNp54Uu49Ey3FQ8IDVkTAOhC1WVEaxgKq53Mf2H4Yut76ldm5EoAypQ7kurOY0FwzMnrIEwH0iwPjQW0QZ8yjIZRguSpRZUCmuYsCIkvrbPkyztdh+8pyzZGxiF1mZCPiBKz0UIgSYBB2Z04KOjRKwjLRhEmkNn8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uCrpx6Qz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZtcHqsoR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:57:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk2zHc4UGV4p9zgKKhiFXYyHqR0zL+qbYUvXcNbvxkQ=;
	b=uCrpx6QzqHWjCVCBJve2YS+Z2CAjdrEQqhf1VTM3vsPfoZrSMO87FHj38p1JGF9yQnfbvL
	T/9TyM/dbROtNyHvrk1PmBLGRV1coyjJdprwhh+KOhNz+7TTUngoy7lT+kmAD0bubtaLbY
	x8zRLi82ZlgB3ePsJKVffhF3hAa4wUTywj51vYNDy78WazmBHT6pAlr/9MgGVv5A3LWViL
	0NhEMktDwV+uKYofeB//UkQiTuRSRi7Mr7OyyYfjNcpYDuTAF8Z1BPY8vVZcjk9gYc9Hbh
	aFPGQlk50tAuRmMr/CL8mWyFIs6IdUgismC0m6tld9jqqgNE1Jvo1szL1zKgnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk2zHc4UGV4p9zgKKhiFXYyHqR0zL+qbYUvXcNbvxkQ=;
	b=ZtcHqsoR/8zTBQTWfME7UMTb3NcUF9DHQQj/hAqDKSi2QRxUXlOmJGpApmJoy2IPc8XQhI
	yBiD/gVdEIPwe3BA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] sh: Switch to irq_find_mapping()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-43-jirislaby@kernel.org>
References: <20250319092951.37667-43-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660467570.406.7603870509266826321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     f2ff6a0df6e5e3ac26c052cbe0dea4f4f46fc5a7
Gitweb:        https://git.kernel.org/tip/f2ff6a0df6e5e3ac26c052cbe0dea4f4f46fc5a7
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:24 +02:00

sh: Switch to irq_find_mapping()

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-43-jirislaby@kernel.org

---
 arch/sh/boards/mach-se/7343/irq.c | 2 +-
 arch/sh/boards/mach-se/7722/irq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index 8241bde..730c01b 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -71,7 +71,7 @@ static void __init se7343_gc_init(void)
 	struct irq_chip_type *ct;
 	unsigned int irq_base;
 
-	irq_base = irq_linear_revmap(se7343_irq_domain, 0);
+	irq_base = irq_find_mapping(se7343_irq_domain, 0);
 
 	gc = irq_alloc_generic_chip(DRV_NAME, 1, irq_base, se7343_irq_regs,
 				    handle_level_irq);
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index 9a460a8..49aa3a2 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -69,7 +69,7 @@ static void __init se7722_gc_init(void)
 	struct irq_chip_type *ct;
 	unsigned int irq_base;
 
-	irq_base = irq_linear_revmap(se7722_irq_domain, 0);
+	irq_base = irq_find_mapping(se7722_irq_domain, 0);
 
 	gc = irq_alloc_generic_chip(DRV_NAME, 1, irq_base, se7722_irq_regs,
 				    handle_level_irq);

