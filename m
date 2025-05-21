Return-Path: <linux-tip-commits+bounces-5735-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B8ABFAEA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8E99E7DFC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7456427AC43;
	Wed, 21 May 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nj2EvFux";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HOjvwW4e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67728A1D3;
	Wed, 21 May 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843072; cv=none; b=TYh4KqUNyDr3gKM1YvKmkVT2L5VwMg2kVkpaiYO6GrC7n/tdS3M0TXnqJIYrLfmkmG+TsSR2PJ3SpnU9HRN+SFAgPbKwYkRYUxZu6CPG4/aqh8X6tX1aKdjQ7KAreAbQHSPn8NQydWZXVpyfg0oNYGVguBDxXYMI0Zn+S3VXp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843072; c=relaxed/simple;
	bh=EwMOOm/VikazqdL/iOOXHk7NIF58SsP/rn6S1g9zonk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gUXX0ViSp9d32hxyIqAaeuCycZ311xhoEusOG0ncDAwW8yiy0v0Uwz9TRNfFOhBcCSRLwsM+SCjPDJEAr9RKrQlp7wKP+XFZlQ/EArtd163fEh6toQWb2KuM2XNpSpKmXaNUbZxNLnrAxmUEWjHyh+Al5q2TsaQfPPpf2Ahj9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nj2EvFux; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HOjvwW4e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:57:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747843065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvciPobc+JOW8+PXMBZH0zQWfd9twjsNJhiUolzqgyo=;
	b=Nj2EvFuxUDwk0UxaNmj8UmJSBF7SVWly3MgwRP3Az8/huvwVzx9/E+NAOD2SeZReejMxqe
	JHCmQvw2I69md3TUh73ZQXdgsCN3Ko+9tLhc1zJf1olCNE0KceXq4F/r513bNZvfU00NeY
	uTADlNKuusQiow14T0A3/tiyStIW0QmUc/FAhOgcHOGS9cwPQoY+2UvdDxOrt/KHMfR7dU
	I2CDFbdEQss5KQPnhSlN/BDknXpq3r62JaFxVzZ5oIZjbVsWmt1J/n0A5Wv3RNYmb9arGK
	+P+BR0uZCKY+zqSBKIEOAPA6LIsmh+Ah/na220XDUxXfwC9pVW4bAo8w2MGDUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747843065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvciPobc+JOW8+PXMBZH0zQWfd9twjsNJhiUolzqgyo=;
	b=HOjvwW4eqN6Z8fMMcdoNEDCynnIdt6IacxeqJBFBbOAYZoarM8+RnWXbQ65ZZWia8vSSrB
	0f86tHSuQFhwwaCw==
From: "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdesc: Remove double locking in hwirq_show()
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250521142541.3832130-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250521142541.3832130-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784306392.406.9650043358804668977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a510bb87da72aa8d1504b0e4b343cfe013ee8a89
Gitweb:        https://git.kernel.org/tip/a510bb87da72aa8d1504b0e4b343cfe013ee8a89
Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
AuthorDate:    Wed, 21 May 2025 17:25:41 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 21 May 2025 17:48:23 +02:00

genirq/irqdesc: Remove double locking in hwirq_show()

&desc->lock is acquired on 2 consecutive lines in hwirq_show(). This leads
obviously to a deadlock. Drop the raw_spin_lock_irq() and keep guard().

Fixes: 5d964a9f7cd8 ("genirq/irqdesc: Switch to lock guards")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250521142541.3832130-1-claudiu.beznea.uj@bp.renesas.com

---
 kernel/irq/irqdesc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 6d006a6..b64c57b 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -281,7 +281,6 @@ static ssize_t hwirq_show(struct kobject *kobj, struct kobj_attribute *attr, cha
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
 
 	guard(raw_spinlock_irq)(&desc->lock);
-	raw_spin_lock_irq(&desc->lock);
 	if (desc->irq_data.domain)
 		return sysfs_emit(buf, "%lu\n", desc->irq_data.hwirq);
 	return 0;

