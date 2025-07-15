Return-Path: <linux-tip-commits+bounces-6120-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD08B057C9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jul 2025 12:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E0C4A6844
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jul 2025 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C701726D4C0;
	Tue, 15 Jul 2025 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TsEOJx65";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="soYwVJ1Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B99C26A0ED;
	Tue, 15 Jul 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575321; cv=none; b=Y6p0WCwsLCmhe4Ns6H2Oenlrl9vC6rl+aAuJy0Q3hCrXEILa0DBA0SYSpP3Hy5ewclvSY7F/zGBimh8FupgYFLiee8KVTtldWUuFAKB4pjJJt8i1pd5LUxBiHmL8F1sfWivQnqzKrKaUAjY47maq+iDm3Obo/hPlRNSo22GtDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575321; c=relaxed/simple;
	bh=sFh+B+55RXm+01ILaiLrwgBwteFQwsKAhXdln8ktuoA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kyAt2kL3gmAGJoPHcwxjWdpeV5w37bbVtIYLxSv8MUglQZrM1LZ2vdRkYTBowVcVF38lxaOEfsGVlsnhynHZLAuA97knNg9ogtd6WLFZNBW4X3USpgpoNFaK6tmfX7GsKfGoP284fIZYy958JeegiNj2sew1Frcf5erSEw7yrHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TsEOJx65; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=soYwVJ1Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Jul 2025 10:28:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752575318;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agesW75C8Qh4vKNKVu6oUg12sdzwFr45Ui3Bkd7Z+ws=;
	b=TsEOJx65zXHC8I54wpAIIkA8r2WNV2v1RJjILP/TiR8hSj323ZJn4fSCQvoy7bXpJKWkVH
	WHZmGmsRidS4UaYt9sUE71RvF98Dn3wfXHwnYyGcwyWj+SFvJRqL5GzgKMdefswxPrtjxh
	4/GWaNm08+r3lw/qy8pcMXFAVT9GoYqctq5Ite2WvrTUCbIl1hwhGsN7hmXUX+aIWHzI6Q
	p4VEUpWOKDUhT7AsaE04xyHPK/1DIDawEF6R27OBBI6N19r3EeAMz+0s0uxmd3KGN6Zj85
	bY5P10U0fuln1Q4TvUNqvqQvv2mrDMwd7NvTY4crwRBi5ms4xUG2vPlgkuNTVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752575318;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agesW75C8Qh4vKNKVu6oUg12sdzwFr45Ui3Bkd7Z+ws=;
	b=soYwVJ1YHuLXB6ntC0ksuLh5+N7oZ+urmEXCpfsva6rJuF7DlE/99d2awjGGC+GLLrwFdS
	nqyJcG1SYOG3sLAQ==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/apic: Move apic_update_irq_cfg() call to
 apic_update_vector()
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250709033242.267892-18-Neeraj.Upadhyay@amd.com>
References: <20250709033242.267892-18-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175257531725.406.4193196668529093010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     7f2b41ac3f29f682cde113f1d0b4b43d261902fe
Gitweb:        https://git.kernel.org/tip/7f2b41ac3f29f682cde113f1d0b4b43d261902fe
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Wed, 09 Jul 2025 09:02:24 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 15 Jul 2025 11:54:09 +02:00

x86/apic: Move apic_update_irq_cfg() call to apic_update_vector()

All callers of apic_update_vector() also call apic_update_irq_cfg() after it.
So, move the apic_update_irq_cfg() call to apic_update_vector().

No functional change intended.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250709033242.267892-18-Neeraj.Upadhyay@amd.com
---
 arch/x86/kernel/apic/vector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 93069b1..a947b46 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -183,6 +183,7 @@ setnew:
 	apicd->cpu = newcpu;
 	BUG_ON(!IS_ERR_OR_NULL(per_cpu(vector_irq, newcpu)[newvec]));
 	per_cpu(vector_irq, newcpu)[newvec] = desc;
+	apic_update_irq_cfg(irqd, newvec, newcpu);
 }
 
 static void vector_assign_managed_shutdown(struct irq_data *irqd)
@@ -261,7 +262,6 @@ assign_vector_locked(struct irq_data *irqd, const struct cpumask *dest)
 	if (vector < 0)
 		return vector;
 	apic_update_vector(irqd, vector, cpu);
-	apic_update_irq_cfg(irqd, vector, cpu);
 
 	return 0;
 }
@@ -338,7 +338,7 @@ assign_managed_vector(struct irq_data *irqd, const struct cpumask *dest)
 	if (vector < 0)
 		return vector;
 	apic_update_vector(irqd, vector, cpu);
-	apic_update_irq_cfg(irqd, vector, cpu);
+
 	return 0;
 }
 

