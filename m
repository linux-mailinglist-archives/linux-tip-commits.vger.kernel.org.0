Return-Path: <linux-tip-commits+bounces-6521-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96260B4A900
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 11:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C742188F5B6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 09:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543602D63F9;
	Tue,  9 Sep 2025 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hVq5xB0t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ARzOCHq3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA722D4B66;
	Tue,  9 Sep 2025 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411524; cv=none; b=Q0O1UuUrhm1YRgU+uh0ZqD+tOgZqCu3cLNS1opinyU0fDLG1NSuwxHkwZ2rFExatV5vX9P3eYqFEylAx1CU4YcSZ5ywjusUwjx47LOr30SpEdYGPqvWz6NOUhs9jD9fMMDeqRlBqedF9Z/iFIp6Xigjn/NX9wLqacCyfDuCqvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411524; c=relaxed/simple;
	bh=7SbH784b9dn3tZhEB6RZBofvTLsnnd9wVrSACaDfTV0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RA6DlO9YPzcD7sJPwKlj9+SGGCkxiSJb0tY/DBLbWj5RgxvllKWnM6zzTxcd6NFeCX3ualpQ3mx79OTZW8cGJKsSiFI8CKOrAfPzjGYnrQyIHGQeZPkjmF8ylfBmwRNwsMd+gr3FkGaAKki/XzNz/n5tT26g2Hze3loFtJGrWLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hVq5xB0t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ARzOCHq3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 09:51:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757411520;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Imt5LeJHKsdko2mt6/SdLhFWi+KJddkQpHLarvrcEt0=;
	b=hVq5xB0toZQmV/wurOUCZhaJ3ASzHRvl5Xzd5a9SSMdwlbV50NHQpJo8FQtXirVJgqOun9
	UD0R9YYGpWBAqInoDzAj9mZHKmF2x3VmB/6bnk2GJ9ZTzEGuc2IzkGxf6hlQoIcbiBblMb
	yz3uBxE7a9HShAtoOKZCY/TcJ1SrEq4FSU0A2DuywruNsdjDXg+k6hwcxC/fj8dotveItD
	caEJN+xWfkxkKOg55OHbgcKRJenmuQm4DHkHP5qk6WA5AXeyZBEoj4+xZhqlc6ZRXuWheq
	fj3ktSevfZ5J/1UNOqUU2R83gekkB9JjA9h3mo1E6IooKGt8bYiPg9n9SY0dPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757411520;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Imt5LeJHKsdko2mt6/SdLhFWi+KJddkQpHLarvrcEt0=;
	b=ARzOCHq3bMvOPYUq/0PM7jGO3OU+ay1LhbtczXDdewdJ4a9iOd0tvz5rWniyazhACQH04O
	/klsSeaBkjEeBHAA==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/gic-v5: Fix loop in
 gicv5_its_create_itt_two_level() cleanup path
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Zenghui Yu <yuzenghui@huawei.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908082745.113718-3-lpieralisi@kernel.org>
References: <20250908082745.113718-3-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741151932.1920.14765779051949167224.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     bfcd1fdaae92faa8cae880eb4c3aaaa60c54bf0d
Gitweb:        https://git.kernel.org/tip/bfcd1fdaae92faa8cae880eb4c3aaaa60c5=
4bf0d
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Mon, 08 Sep 2025 10:27:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 11:51:09 +02:00

irqchip/gic-v5: Fix loop in gicv5_its_create_itt_two_level() cleanup path

The "i" variable in gicv5_its_create_itt_two_level() needs to be signed
otherwise it can cause a forever loop in the function's cleanup path.

[ lpieralisi: Reworded commit message ]

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/all/20250908082745.113718-3-lpieralisi@kernel.o=
rg

---
 drivers/irqchip/irq-gic-v5-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-it=
s.c
index 81d813c..dcdf8bc 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -191,9 +191,9 @@ static int gicv5_its_create_itt_two_level(struct gicv5_it=
s_chip_data *its,
 					  unsigned int num_events)
 {
 	unsigned int l1_bits, l2_bits, span, events_per_l2_table;
-	unsigned int i, complete_tables, final_span, num_ents;
+	unsigned int complete_tables, final_span, num_ents;
 	__le64 *itt_l1, *itt_l2, **l2ptrs;
-	int ret;
+	int i, ret;
 	u64 val;
=20
 	ret =3D gicv5_its_l2sz_to_l2_bits(itt_l2sz);

