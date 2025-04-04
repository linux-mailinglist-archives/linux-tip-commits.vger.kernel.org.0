Return-Path: <linux-tip-commits+bounces-4664-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A78A7C059
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47170189B3C5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55741EFF9D;
	Fri,  4 Apr 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sq4TDEFV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IohlGRpv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5021EF0AD;
	Fri,  4 Apr 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779663; cv=none; b=EJ7LJnZXV87nopS4wqUPKHrORDKUswMhesplutNQ8kgJbDvxIhelJUOw3DU+f8P0KzTwVKvN+hJA5OgARyRGOHgx6h2Di2WldE2taI1eXD+0AXY/iEKRF+clMSy0Jys9FWuPCuDx0xqS+KItRGCyRH/f71v0JYL7BV6ffbDekX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779663; c=relaxed/simple;
	bh=evAovIBbD/uzBeMvoHDbt24jYAMqbvFBAa/ChPerOfs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WN8E7CYxXrzZ1nj4lK98AKz66JW8NiRcYqIZdk9J7Wol1sA8lOCRbq4zLNelp2hbsOp+NxDzl9byukCYCZGQ9k7aucCn8nyAZdcMBX6BEeUJKrRailAAr3EEbYFgFtTCLV4JuJ0PdrAzVImFGbnymyU1t1ObTY5ntcXqNDXvYo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sq4TDEFV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IohlGRpv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 15:14:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743779660;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zG4YgNteA6hLvHRqyJ6K8KbsFLMnLYKMqLhkRxS8f0=;
	b=Sq4TDEFVIaOtZ2v1+coTXeLJ6z/5lWOb7KgB8QxFnl6s4CPPPGxy1w7oplhfvrX2Dheo7r
	JJUT8p/dLXcO0r22Eh8l84Jniy+meb7T91EV2UXE4cVo0ORvLkBP7fzI5Oum5r4OzzGcmX
	nsF1gHdXJ+3B3DYzG8yr/B9cI6dCXBefmdsS4PfPCl+TXFhHHJ8vyDL2nrxZzlXZOEHDcl
	INtEVZCb8KmPxba8ko7hiVMvRh7YwFJjnjBfX+/1a0KGBbhhZBD/5TxFsicCZGPl/jaFFi
	NICtvFjSoP2RVe+4zyVJQ1uB0bhpRM0TA+78qMpI9XTapwVfVmTH/QuH1BHcig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743779660;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zG4YgNteA6hLvHRqyJ6K8KbsFLMnLYKMqLhkRxS8f0=;
	b=IohlGRpv+E9qEUZ867Jod95nR4YUdeAh7LC+EqoB8nbGrjDw9SdvNulMrHXaCcIA93Rlg2
	AGRmicIp/ffjquAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/migration: Use irqd_get_parent_data() in
 irq_force_complete_move()
Cc: Frank Scheiner <frank.scheiner@web.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87h634ugig.ffs@tglx>
References: <87h634ugig.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174377965732.31282.158574464632397701.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9b305678c55dd45044aa565fee04f8d88382bc4d
Gitweb:        https://git.kernel.org/tip/9b305678c55dd45044aa565fee04f8d88382bc4d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 04 Apr 2025 16:51:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 17:08:36 +02:00

genirq/migration: Use irqd_get_parent_data() in irq_force_complete_move()

Frank reported, that the common irq_force_complete_move() breaks the out of
tree build of ia64. The reason is that ia64 uses the migration code, but
does not have hierarchical interrupt domains enabled.

This went unnoticed in mainline as both x86 and RISC-V have hierarchical
domains enabled. Not that it matters for mainline, but it's still
inconsistent.

Use irqd_get_parent_data() instead of accessing the parent_data field
directly. The helper returns NULL when hierarchical domains are disabled
otherwise it accesses the parent_data field of the domain.

No functional change.

Fixes: 751dc837dabd ("genirq: Introduce common irq_force_complete_move() implementation")
Reported-by: Frank Scheiner <frank.scheiner@web.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Frank Scheiner <frank.scheiner@web.de>
Link: https://lore.kernel.org/all/87h634ugig.ffs@tglx


---
 kernel/irq/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index 147cabb..f2b2929 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -37,7 +37,7 @@ bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear)
 
 void irq_force_complete_move(struct irq_desc *desc)
 {
-	for (struct irq_data *d = irq_desc_get_irq_data(desc); d; d = d->parent_data) {
+	for (struct irq_data *d = irq_desc_get_irq_data(desc); d; d = irqd_get_parent_data(d)) {
 		if (d->chip && d->chip->irq_force_complete_move) {
 			d->chip->irq_force_complete_move(d);
 			return;

