Return-Path: <linux-tip-commits+bounces-5522-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0BBAB4D3E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 09:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94FF16785E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 07:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71D1E9B30;
	Tue, 13 May 2025 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nd6wse+Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XSKuUMrw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97137A93D;
	Tue, 13 May 2025 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122408; cv=none; b=umpdDBJp194Uv6nrfdoZ6aBL7AvVX/yvZPh1ZzkrWSeOgqaFXLVFTLPmlZXp1wMhkrH1XfSdBlI6LAO/ndiiXyQ8Sy8Y3HFSEePGikznJ4ddHmLTgq4uZaXsTAnefIuM4IGgNk8tDO3Zh7uWWCt19qB129TcbPUQnhd56U8ZAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122408; c=relaxed/simple;
	bh=8FBiqhN5H35RaYROUBev4SesBXxxx5NEMaLO+Qky6aQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U76yQ4SjjeU5Tq5n+IOnVW3ZcgA8Sf/2tk7s+GA3CkB/QPW23kib9gDnzqiahFYKW1DbUC/JBi0Z4HYgPLA+c0QtzKdgfGMueshkyte44c2YcEsd5XuQTv2++5IldLDgfWP6jzdLmAZJzyinJTF0y6Erf/E0yIhHFD+K6jgJN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nd6wse+Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XSKuUMrw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 May 2025 07:46:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747122404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mbk6bgKEKCMg9tpzobjGkIX/TElNPj9RwXo/ZFwMz8=;
	b=Nd6wse+Z4XK31NOzX9JGPhzFp3y/JXn0dXYDvC2Sjba/250UkHJdQsAYkG04c1XZzXp7qT
	ueZ3OTDzDdN0G4cu64S8kkHiE1BvM0c7ZatMzjvCb+bjRw/Y9hmn3bLQ0hk3HfR50NOgRH
	4YWZhqXQ/862TEA6p9d5HLoPfozx1WnknJNsrt23Op8LORbpbeelHqSQUVqfVAXgA5Zi1z
	7BSh/RM63Om92fnjq9N//CVO3n4nZShdZAFTVfx+0ZWQqIFMpuZLUCjN1cf1o34JaMa8YL
	AtkoB4o45Q45ugSfRc0nROMS5sD4+B1NPCo4PmLLOC3nCWU+9Wdz54d+sOP8UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747122404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mbk6bgKEKCMg9tpzobjGkIX/TElNPj9RwXo/ZFwMz8=;
	b=XSKuUMrw8+SGMZFdd/LaDTP4paQ4Xjg+BWyOAxw8NW08HIqKtbgk/2hBfVBOt+KCfTX92W
	HZ58FNNBIlsswQDw==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Consistently use '%u' format specifier for
 unsigned int variables
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250509154643.1499171-1-andriy.shevchenko@linux.intel.com>
References: <20250509154643.1499171-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174712240369.406.8331862858808951704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     47af06c9d31fe558493de4e04f9a07847dc4992f
Gitweb:        https://git.kernel.org/tip/47af06c9d31fe558493de4e04f9a07847dc4992f
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 09 May 2025 18:46:42 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 May 2025 09:43:32 +02:00

genirq: Consistently use '%u' format specifier for unsigned int variables

There are three cases in the genirq code when the irq, as an unsigned
integer variable, is converted to text representation by sprintf().
In two cases it uses '%d' specifier which is for signed values. While
it's not a problem right now, potentially it might be in the future
in case too big (> INT_MAX) number will appear there.

Consistently use '%u' format specifier for @irq which is declared as
unsigned int in all these cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250509154643.1499171-1-andriy.shevchenko@linux.intel.com

---
 kernel/irq/debugfs.c | 2 +-
 kernel/irq/proc.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 9004a17..3d6a5b3 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -230,7 +230,7 @@ void irq_add_debugfs_entry(unsigned int irq, struct irq_desc *desc)
 	if (!irq_dir || !desc || desc->debugfs_file)
 		return;
 
-	sprintf(name, "%d", irq);
+	sprintf(name, "%u", irq);
 	desc->debugfs_file = debugfs_create_file(name, 0644, irq_dir, desc,
 						 &dfs_irq_ops);
 }
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 94eba9a..29c2404 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -309,7 +309,7 @@ static bool name_unique(unsigned int irq, struct irqaction *new_action)
 
 void register_handler_proc(unsigned int irq, struct irqaction *action)
 {
-	char name [MAX_NAMELEN];
+	char name[MAX_NAMELEN];
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (!desc->dir || action->dir || !action->name || !name_unique(irq, action))
@@ -345,7 +345,7 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 		return;
 
 	/* create /proc/irq/1234 */
-	sprintf(name, "%d", irq);
+	sprintf(name, "%u", irq);
 	desc->dir = proc_mkdir(name, root_irq_dir);
 	if (!desc->dir)
 		return;

