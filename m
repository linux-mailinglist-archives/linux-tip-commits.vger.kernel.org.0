Return-Path: <linux-tip-commits+bounces-6778-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3721BC09FD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 07 Oct 2025 10:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABA8A4EF0EF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  7 Oct 2025 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFDF2D3EDF;
	Tue,  7 Oct 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhQA9eQi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="29hV0++4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA82D29C8;
	Tue,  7 Oct 2025 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825677; cv=none; b=cki6sr5ow37lPbgUJIY4i1YmAEcWk04H/gjvmQRwzupAjU0wIeDNo7nWE6C4LRFYy/kxSY7M6CC4PK8fDq1El9Fbh6lNJra9WTsnRa6NqZ+KnBfXFE2AC5ZD/jN3Xc1HZbfdge0zXoNBkS2pk4HmF0i0slX29Mwfkm6DHn6DPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825677; c=relaxed/simple;
	bh=tRqtA0eI6mSTuc44XsLoqE75ujNTDTG2BylOj3aELIw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dlA0WC/dVrJVeAq3HOdOaXlxUgYp/DgvU+23SVSUKaz7wILeeIkZKAvPTVEVrBCrtSFo2BKYm6wio9o3lRWSiEja+C1PASeIOERxV8Ma1A7Xwhbzxd9IJQwglADSFIzxzg6XneqYkbE8fTLftCMYQ5X5J6rWuRm4V08GRU5YOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rhQA9eQi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=29hV0++4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 07 Oct 2025 08:27:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759825674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NATlKt9k4cEnUSW64I8OamWdKxO6LU6vZ6tZA11+Rb8=;
	b=rhQA9eQiKAXf0XvMw7g4Me58EW3fkIkY8b/ACw7x3TbsoXKJOe0hBHkF+1G/1YLeSrWyB2
	Rv7NCdKjwOV95aHnfEjSPP9FIHRaanJz6HcJwD7Ha/6FA5mDGkRqxZ+ikmW+HJgLJy68+d
	Hwn4oZUZ5Uv9qniO19BNLN1ZVDm7ZLgzaiNc854KFbtNtGwLU5ddDrzJ9JUj9PkEd5vrQF
	vwNmosoDoImnYE/CrWCXSqulsP6qLoJVPPvrOVlUMH7IeHiwIZLnC8CjH1KogpshRlfWuq
	1p2FZ3ttJzvTp1GEOOnQObLk5wLM4oSMojiU/pyf0Wztt8VN4qOiR+9Df18Qwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759825674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NATlKt9k4cEnUSW64I8OamWdKxO6LU6vZ6tZA11+Rb8=;
	b=29hV0++4mJ9fYR9skOITrF/q2ISIdfSkakGSrEawHGrACXedzV4ad2PM6mMPFkXcpdXS93
	WQfDFDjiyHf1RvCg==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/aspeed-scu-ic: Fix an IS_ERR() vs NULL check
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <aNfX3RiyIfr3A0ZG@stanley.mountain>
References: <aNfX3RiyIfr3A0ZG@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175982567298.709179.7283098755702154844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     196754c2a04a8ba682b00ea7c818897295c98967
Gitweb:        https://git.kernel.org/tip/196754c2a04a8ba682b00ea7c818897295c=
98967
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Sat, 27 Sep 2025 15:26:05 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 07 Oct 2025 10:23:22 +02:00

irqchip/aspeed-scu-ic: Fix an IS_ERR() vs NULL check

of_iomap() doesn't return error pointers, it returns NULL.  Fix the error
checking to check for NULL pointers.

Fixes: 86cd4301c285 ("irqchip/aspeed-scu-ic: Refactor driver to support varia=
nt-based initialization")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed=
-scu-ic.c
index 5584e0f..bee59c8 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -215,8 +215,8 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu=
_ic *scu_ic,
 	int irq, rc =3D 0;
=20
 	scu_ic->base =3D of_iomap(node, 0);
-	if (IS_ERR(scu_ic->base)) {
-		rc =3D PTR_ERR(scu_ic->base);
+	if (!scu_ic->base) {
+		rc =3D -ENOMEM;
 		goto err;
 	}
=20

