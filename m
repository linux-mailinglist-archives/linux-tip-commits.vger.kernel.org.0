Return-Path: <linux-tip-commits+bounces-1422-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB18790B5CE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 18:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ACFBB383FA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2221D3285;
	Mon, 17 Jun 2024 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I5Kjt+db";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hljIa/Wy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A061D0F7C;
	Mon, 17 Jun 2024 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632281; cv=none; b=gMMC1ebxgu7iaFNsTohKEnDH781v9410Uww7Tsu6vWBLkNEriziqDuVvJhqj77e0rpGvGRpJtgu1TD1RVIXPsO1yhHaCYSjalIPeud1A2UzJ4C0Oph+LcJD8hqtGT4E4qHImJwGYGSHXvVSOvLzIUNmKPGX8r6b4koq+8rb36bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632281; c=relaxed/simple;
	bh=LtF4g6ROECNNE25ziqP/kOyVwEakCdfaB0kgg8izl2U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=anKEvSXIRoYh6dYPEy9TTSwnWJqrcV/O6chz+hVfW+cTuhcxGitUnzwLFg74Qtjqlt6yGeaQ2yOQ66BkZYS27vN3qUcec2YjHiPt+VzARGkSDEGfnODAJn65Ad+1GvEVSAJDYS2g89d6VUMqk/yNKDsmBdWwGWwL8DOLuKxdyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I5Kjt+db; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hljIa/Wy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DJpdJA4bcgAFIp89Doc6r/aZhiM2NotVs1TSAgTejQ=;
	b=I5Kjt+dbrYmfmnKg0FuWEdQ1Z7Ztn4U+sJVmCGqgIHLw4bgdCucGM9neDhTZMnS2r4JGrb
	hq4itBRcpOfVsN6fvoVqTYGtejdOskNPcYNjqAXXX+BHrsbkEMFZzgvuByDkhxGzLdyR9b
	Sei7neVQ9SgFKPdDVHoZMzNuEBgFAritRIOYhU+OVpYoQA1ll8AVd795c70ONGIBtPs7Am
	5sBy3QrsdIknzpj9raOz5FzZE+noglpt5O2/f2kp4Bt/I/Gduc/+1XEJNwSdw0tQPqITe7
	PeKPP+j9OqZxwLjJS/aRv0s/PwviZIyxsI9kW5kMQBzLkQpq2Ua/AzrHaaz32A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DJpdJA4bcgAFIp89Doc6r/aZhiM2NotVs1TSAgTejQ=;
	b=hljIa/WyHo8XGbKYIZyCKzCvD7hYFAP0oY87xuvbxu5VaEAIIsaLMSx/2P/7jvA0ykmqW+
	2RS38138MTou21Aw==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Handle domain hierarchy parent in
 irq_domain_instantiate()
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-9-herve.codina@bootlin.com>
References: <20240614173232.1184015-9-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227199.10875.14552166578816704076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     419e3778ff295c00aa158d9f2854a70b47ba1136
Gitweb:        https://git.kernel.org/tip/419e3778ff295c00aa158d9f2854a70b47ba1136
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:13 +02:00

irqdomain: Handle domain hierarchy parent in irq_domain_instantiate()

To use irq_domain_instantiate() from irq_domain_create_hierarchy(),
irq_domain_instantiate() needs to handle the domain hierarchy parent.

Add the required functionality.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-9-herve.codina@bootlin.com

---
 include/linux/irqdomain.h | 6 ++++++
 kernel/irq/irqdomain.c    | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 4683b66..e52fd5e 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -276,6 +276,12 @@ struct irq_domain_info {
 	int					direct_max;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	/**
+	 * @parent: Pointer to the parent irq domain used in a hierarchy domain
+	 */
+	struct irq_domain			*parent;
+#endif
 };
 
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 26ad1ea..1269a81 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -265,6 +265,13 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 
 	domain->flags |= info->domain_flags;
 
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	if (info->parent) {
+		domain->root = info->parent->root;
+		domain->parent = info->parent;
+	}
+#endif
+
 	__irq_domain_publish(domain);
 
 	return domain;

