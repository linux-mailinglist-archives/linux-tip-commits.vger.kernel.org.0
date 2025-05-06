Return-Path: <linux-tip-commits+bounces-5276-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D975AAC5BF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360991882D24
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F4028312D;
	Tue,  6 May 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i6LtevSE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XwtV4khq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE8281516;
	Tue,  6 May 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537623; cv=none; b=iO+xyw24wdL/l+M6dIaAqeYRCeeM9c1DL2CPd68dC0DgL07IP3WfsWC1qzpxqHXiwOXXVbUxTN34XW7kNd8th9D83D97c5sPfMkfVrxAzXu0ILczOOZtBV0fY2eKeBDwLh1VySLvwZMM6hBX3KjnaLQVaq+80LHoyVyNlCT9Kgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537623; c=relaxed/simple;
	bh=0UnNFRI9KEu0z9/S+CI1y5ZUqPL5naS0s+QlJ2erJhE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SdGc1OHFUopGWn8v/dPkFhw39ohqnpL8OakDi4bXfYwqeO+MWgmzxR4seJ4V49qa5S3PulC0Z1DZkBvvS8VVLpzY7HmJTsIh0lQ4sAgoc6faMVL3aAGPDP69/GCvnUw72hNxsKzQkVi9QoAHhIDqKtM1eo/cPvpDw7PC4c8W8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i6LtevSE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XwtV4khq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6gZNL+Q8hvBktsF/QQvjbw/8ec04uLMeSdLcqa+xiM=;
	b=i6LtevSEVQ5VyWa7evf5te65a22p/pUxNLHGt2bBpdlKBRIB643Gl/RTgCU4gijpjFfAr0
	emY49Wl/f9c3W+GZirrhM7OoUIQz0r5uIIVNlmUpjgiqxoaIrM1H2+YzmBfKKLWh0OY5it
	BpB3xec3mNxyp3+SlwUoAtHb69iCiOp0H6H5bCmG8/aJ7OwfF/2y15ujXDYNC1IICHSw/g
	sWN58UzjeDMbMq1Zr62ZC4YJFwJqKoSbsE1tDaS2fQ0ryF8cX3bXIq0laHsuraXtk6GjC1
	qhkI8h6HibFue1B3BUIH34X3KXbsWgIcwcHC7ObCy6A9x1ZzbUzlMlOSbIo1mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6gZNL+Q8hvBktsF/QQvjbw/8ec04uLMeSdLcqa+xiM=;
	b=XwtV4khqgKa9VDdNpuLDyh0OuBMwlWM4+i7ltxmWig/GrxYajo41fZLMlGJkmDLi602N1n
	w7/3tAr01L3OqXAg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] irqdomain: Drop irq_linear_revmap()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-50-jirislaby@kernel.org>
References: <20250319092951.37667-50-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653761872.406.17074671677839417273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     8db535d609d73bb3811a81be0027bd7c2c89b4b7
Gitweb:        https://git.kernel.org/tip/8db535d609d73bb3811a81be0027bd7c2c8=
9b4b7
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:08 +02:00

irqdomain: Drop irq_linear_revmap()

irq_linear_revmap() is deprecated and unused now. So remove it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-50-jirislaby@kernel.org

---
 Documentation/core-api/irq/irq-domain.rst                    | 2 --
 Documentation/translations/zh_CN/core-api/irq/irq-domain.rst | 2 --
 include/linux/irqdomain.h                                    | 6 ------
 3 files changed, 10 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-a=
pi/irq/irq-domain.rst
index 7624607..c365c3e 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -62,8 +62,6 @@ variety of methods:
   mapping.
 - irq_find_mapping() returns a Linux IRQ number for a given domain and
   hwirq number, and 0 if there was no mapping
-- irq_linear_revmap() is now identical to irq_find_mapping(), and is
-  deprecated
 - generic_handle_domain_irq() handles an interrupt described by a
   domain and a hwirq number
=20
diff --git a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst b/D=
ocumentation/translations/zh_CN/core-api/irq/irq-domain.rst
index 913c3ed..4a2d3b2 100644
--- a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
+++ b/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
@@ -60,8 +60,6 @@ irq_domain=E5=92=8C=E4=B8=80=E4=B8=AAhwirq=E5=8F=B7=E4=BD=
=9C=E4=B8=BA=E5=8F=82=E6=95=B0=E3=80=82 =E5=A6=82=E6=9E=9Chwirq=E7=9A=84=E6=
=98=A0=E5=B0=84=E8=BF=98=E4=B8=8D=E5=AD=98=E5=9C=A8=EF=BC=8C=EF=BF=BD
=20
 - irq_find_mapping()=E8=BF=94=E5=9B=9E=E7=BB=99=E5=AE=9A=E5=9F=9F=E5=92=8Chw=
irq=E7=9A=84Linux IRQ=E5=8F=B7=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=B2=A1=E6=9C=89=
=E6=98=A0=E5=B0=84=E5=88=99=E8=BF=94=E5=9B=9E0=E3=80=82
=20
-- irq_linear_revmap()=E7=8E=B0=E4=B8=8Eirq_find_mapping()=E7=9B=B8=E5=90=8C=
=EF=BC=8C=E5=B7=B2=E8=A2=AB=E5=BA=9F=E5=BC=83=E3=80=82
-
 - generic_handle_domain_irq()=E5=A4=84=E7=90=86=E4=B8=80=E4=B8=AA=E7=94=B1=
=E5=9F=9F=E5=92=8Chwirq=E5=8F=B7=E6=8F=8F=E8=BF=B0=E7=9A=84=E4=B8=AD=E6=96=AD=
=E3=80=82
=20
 =E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8Cirq=E5=9F=9F=E7=9A=84=E6=9F=A5=E6=89=BE=
=E5=BF=85=E9=A1=BB=E5=8F=91=E7=94=9F=E5=9C=A8=E4=B8=8ERCU=E8=AF=BB=E4=B8=B4=
=E7=95=8C=E5=8C=BA=E5=85=BC=E5=AE=B9=E7=9A=84=E4=B8=8A=E4=B8=8B=E6=96=87=E4=
=B8=AD=E3=80=82
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 712c662..c8e55cd 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -492,12 +492,6 @@ static inline unsigned int irq_find_mapping(struct irq_d=
omain *domain,
 	return 0;
 }
=20
-static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
-					     irq_hw_number_t hwirq)
-{
-	return irq_find_mapping(domain, hwirq);
-}
-
 extern const struct irq_domain_ops irq_domain_simple_ops;
=20
 /* stock xlate functions */

