Return-Path: <linux-tip-commits+bounces-5425-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211D8AAE107
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1574D7ADDD5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C68289E26;
	Wed,  7 May 2025 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i3MD4drV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iXfZUREE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838928980E;
	Wed,  7 May 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625452; cv=none; b=a7Md6sMTP5yGLNVf1/kd680v3usotaRVsjO2zzkH5d1lbrT8r/bUjnD2SbjzAAEOOJX1GNynoRXJa1TfeAxxTfJpKaMwHLTqORxAxGR3Y7Jo26XDXlD9PVeE+6GKmYZZeESZ+ghlf9fUvg0IVZRcN3eU/UBB8donjEPGyb4NJOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625452; c=relaxed/simple;
	bh=1nR16CNZvr1AMWDPgZRjUwVbH4QpJQO7XEyG6sb08N0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gfTq6CpYPRUhJMYovS5MltOiEEHIy5GjsOGPh3vuKrW7jGdom8AKRqFbl++KC1DKszU1WtcfDQdzCU2aM29BIlwdqg+O+ObZqGnIORxtuJlwo6AmeTsMY403yMqPWhO5CtSSK1AtN7VpihjzigZaSc2RszNXdJ1Xp5NrxYf1tPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i3MD4drV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iXfZUREE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625448;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUA2S9WGpVAFNBUghrFAPqjCvkRLj3NeOQQ/D+ogkKc=;
	b=i3MD4drVv2W62L5cXWDrLcM/tLdmPZrEYr/YNvf0FAKdaMAar25wjW9ZpUZP/oyKV+qhcd
	4MHodS4/DYA0QZ+VTPOwnYwlxqxio5rIBzJfuWOgkuYxkhCDPGlo7hNajENuBmd9Kmv4YD
	ExPDvU2bCt+K9xaenbMg+o6bSXrHuc49GmE7Pg8rk9KFoA0wg4huQ0KfOr1EiUgE81ce7m
	COegLRycdX3H7xGAcd2c/XCwe4IvkiRZ27XXrXIzS8cas17quc0Oq2oG85GCk00rSa1iRB
	E/M2XEuM9RDgzD5UYd36K8v1JpaWLeASXuvo8/1FmwTY0vqpp+W4GJxAUaqXpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625448;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUA2S9WGpVAFNBUghrFAPqjCvkRLj3NeOQQ/D+ogkKc=;
	b=iXfZUREEYorc4Gg75TN7zTucXUCzb/3BMh8/snR/T3qcGrEF3IIpRl4Dorw7fFI7HsqmIb
	qW0HAFxySxpbPJCg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] irqdomain: Use irq_domain_instantiate()'s return
 value as initializers
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-51-jirislaby@kernel.org>
References: <20250319092951.37667-51-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662544803.406.16920661410260566750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     d42b432f05c255ddead54dd44adaaf8886c2eed3
Gitweb:        https://git.kernel.org/tip/d42b432f05c255ddead54dd44adaaf8886c2eed3
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:42 +02:00

irqdomain: Use irq_domain_instantiate()'s return value as initializers

This makes the code more compact.

Note that irq_domain_create_hierarchy()'s handling of size is now part of
info's initializer (using the ternary operator). That makes more sense
while reading it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-51-jirislaby@kernel.org


---
 include/linux/irqdomain.h | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index c8e55cd..1e38584 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -403,9 +403,8 @@ static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handle *f
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *d;
+	struct irq_domain *d = irq_domain_instantiate(&info);
 
-	d = irq_domain_instantiate(&info);
 	return IS_ERR(d) ? NULL : d;
 }
 
@@ -424,9 +423,8 @@ static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *d;
+	struct irq_domain *d = irq_domain_instantiate(&info);
 
-	d = irq_domain_instantiate(&info);
 	return IS_ERR(d) ? NULL : d;
 }
 
@@ -440,9 +438,8 @@ static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fw
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *d;
+	struct irq_domain *d = irq_domain_instantiate(&info);
 
-	d = irq_domain_instantiate(&info);
 	return IS_ERR(d) ? NULL : d;
 }
 
@@ -554,18 +551,14 @@ static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *
 	struct irq_domain_info info = {
 		.fwnode		= fwnode,
 		.size		= size,
-		.hwirq_max	= size,
+		.hwirq_max	= size ? : ~0U,
 		.ops		= ops,
 		.host_data	= host_data,
 		.domain_flags	= flags,
 		.parent		= parent,
 	};
-	struct irq_domain *d;
+	struct irq_domain *d = irq_domain_instantiate(&info);
 
-	if (!info.size)
-		info.hwirq_max = ~0U;
-
-	d = irq_domain_instantiate(&info);
 	return IS_ERR(d) ? NULL : d;
 }
 

