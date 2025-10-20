Return-Path: <linux-tip-commits+bounces-6965-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD2DBF2E8C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 Oct 2025 20:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE0D18895B6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 Oct 2025 18:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CD82D0606;
	Mon, 20 Oct 2025 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dc510Gf+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4jY1/YqI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF641EDA0B;
	Mon, 20 Oct 2025 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984420; cv=none; b=ADguHv7xd0T/PGAroc7KZ2Cb6X1YmAGfm0fM88uuBwHVlR2/Rm5G2iUMjwgBkx8e7wo5ltYKWUJJilTTFPYRDFN1O5WtIx6l1KroDmlerRZhojxk/kCkONmR/XfFyMaVI4ZyOJ/OJ1XPd7x87H898JdJbmfPDPdkpVh9Tidos5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984420; c=relaxed/simple;
	bh=+7F+pToV+3z0kjtQBmZ9mVVzN9AivMSujlzvN7xMPZY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WwEtuE82LmXhKr/NhHYgiUVtViMPKpUehGFHhvK5V7ZT+qpDVM82QSME0uK3mBD0iZyu655vcuAK7anvEei5A/CDUDgmJWP3G6+iGfStbBbkwMnjutL3uVJtjOqd/8hASo3D+vBZpsy0BGevtnoC1MncsINhM2wPARR72TQjSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dc510Gf+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4jY1/YqI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 20 Oct 2025 18:20:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760984416;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMSL5YhuHM0+KOZy6EQ+ysTWuNUYxAwDs6k45pUzMpo=;
	b=Dc510Gf+1rb5Hl7l8xF02JeALprUz1GMBLXrZtd/INYBi80JZSs5VFaZ3wLqK6IJTHCfaj
	Y/MU5vlv1wz3GHbXahdnYvmlWPPYsKy1rJAVK1RSdYbVsaZl0lWjnNlS8vnQTMvXy/DNJn
	/gf/k2vnpkbzv3BGJx0bou1Zri6LGpBebFMuj8vsbOD2IjPLnCc5zYl2prtchqy1nZbAyl
	t1cda8KXNMFmpqklNpG7rOs7rmfZUdOjsoFIEbrvCWIXPZ6gRMFSIxihVE1a3MMvVqYC99
	I3slSXzNgsJPHq3HgFcKjx++PQvnv/A+1p5NVD1r+UwyY7736I5WveBxwCX5eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760984416;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMSL5YhuHM0+KOZy6EQ+ysTWuNUYxAwDs6k45pUzMpo=;
	b=4jY1/YqIe9iZL4hcC27TR5E/X4e1P3gQ1wtVIF/YVS6+kvv+Xnmfo2xbDjDj+qFvfoaPnA
	wm5DsR696aYw80CQ==
From: "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Slightly simplify msi_domain_alloc()
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C1ce680114cdb8d40b072c54d7f015696a540e5a6=2E1760863?=
 =?utf-8?q?194=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3C1ce680114cdb8d40b072c54d7f015696a540e5a6=2E17608631?=
 =?utf-8?q?94=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176098441506.2601451.3693832213814934444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     ac646f44956edc9aaa406b4a8fef17888a2166af
Gitweb:        https://git.kernel.org/tip/ac646f44956edc9aaa406b4a8fef17888a2=
166af
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Sun, 19 Oct 2025 10:40:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 20 Oct 2025 20:18:48 +02:00

genirq/msi: Slightly simplify msi_domain_alloc()

The return value of irq_find_mapping() is only tested, not used for
anything else.

Replaced it by irq_resolve_mapping() which is internally used by
irq_find_mapping() and allows a simple boolean decision.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/1ce680114cdb8d40b072c54d7f015696a540e5a6.17608=
63194.git.christophe.jaillet@wanadoo.fr
---
 kernel/irq/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index e7ad992..6888688 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -706,7 +706,7 @@ static int msi_domain_alloc(struct irq_domain *domain, un=
signed int virq,
 	irq_hw_number_t hwirq =3D ops->get_hwirq(info, arg);
 	int i, ret;
=20
-	if (irq_find_mapping(domain, hwirq) > 0)
+	if (irq_resolve_mapping(domain, hwirq))
 		return -EEXIST;
=20
 	if (domain->parent) {

