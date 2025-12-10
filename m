Return-Path: <linux-tip-commits+bounces-7623-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6958CB1B47
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 03:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B4B2301976F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 02:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6D624DD17;
	Wed, 10 Dec 2025 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O5s72nUd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TujfGBb1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913BD24A06B;
	Wed, 10 Dec 2025 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765333192; cv=none; b=s3z9wgp1UJ3jiaV9+J6LD4jwwFDHSvk+uUV76rO4Hk3Jdv1ItQ/9IbxIrmXV1SpXFrVZtjinCEFcVsKOzkqcM7X6S0Oa/JYmErQMt9bGkEIeD9yPzSzMnO0L8c792FZWkE2uBspUJcAl1DDIFjmZbOsKm8FQHi1bGM29wGevtlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765333192; c=relaxed/simple;
	bh=+z7T9ZeO2KWUAjb49ZklbhW0pv0qz9acc+Cej7ryg2k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H3iACDcAj5hUa2dwFHJCpGr8VEabTmRKBUUz6aMXL45v80Ym+6l2GTZQx/sl2IB0Q8ABk6UAPKlEfQwLhQ+Pi9gWqBWn0tFJ5iEBdNc6dre9cW5+ifXAX23/TmXWEzAaoug5VNj1UMUSyF8yjq/sdlWXNip1yzuIXwkNNyYekco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O5s72nUd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TujfGBb1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Dec 2025 02:19:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765333188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSXHNpQ125tpHkdcax9DCN7oEJgkS+5DQOKzYjiP+cI=;
	b=O5s72nUdUToemFI5hOW6dHwxMn/eL42Ot5PMFi72LOATRxfMv2j/6+ZadVjATH7uCdprhp
	WjgEHr+c39IbHba/hWrsN6u7vlEGXaTWsLrB/bSN98bBUnCXVrWv0ex1+/PygMbP1oOeA8
	66kDG0ZDvDvvziotbb6D73b+l61SoE+1RUwp5/TwcfI8KHYdQ+fEmMAGdCZ1RI01uB+dMR
	jnHSHrgOrDPq33ahjGryBTAlfgaW3HDOnU2d1TO9QI+F0y52+3+X3fK50xDSug6VK0PXjy
	CW9CUihZlGQdWXd4VfM9V6hn0kd2O5ALZfQzwIywALaF01ubQ/AXHzqgJ/oxvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765333188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSXHNpQ125tpHkdcax9DCN7oEJgkS+5DQOKzYjiP+cI=;
	b=TujfGBb1YjveLljbFCaSt1MTkPuscXipk/GxIBnWBVUhFABpdXsFQvimv5jGAj3hGejcZo
	nDQDlxpxWKSDtQBw==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqdomain: Delete irq_domain_add_tree()
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251202202327.1444693-1-andriy.shevchenko@linux.intel.com>
References: <20251202202327.1444693-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176533318620.498.712866201511205615.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     55026a9670ce8b7b3d74f7d570de1382cbfb395d
Gitweb:        https://git.kernel.org/tip/55026a9670ce8b7b3d74f7d570de1382cbf=
b395d
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Tue, 02 Dec 2025 21:23:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Dec 2025 11:16:50 +09:00

irqdomain: Delete irq_domain_add_tree()

No in-tree users anymore.

[ tglx: Remove the reference in the Chinese documentation as well ]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251202202327.1444693-1-andriy.shevchenko@lin=
ux.intel.com
---
 Documentation/translations/zh_CN/core-api/irq/irq-domain.rst |  4 +--
 include/linux/irqdomain.h                                    | 16 +-------
 2 files changed, 20 deletions(-)

diff --git a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst b/D=
ocumentation/translations/zh_CN/core-api/irq/irq-domain.rst
index 4a2d3b2..aaefeda 100644
--- a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
+++ b/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
@@ -109,10 +109,6 @@ irq_domain=E7=BB=B4=E6=8A=A4=E7=9D=80=E4=BB=8Ehwirq=E5=
=8F=B7=E5=88=B0Linux IRQ=E7=9A=84radix=E7=9A=84=E6=A0=91=E7=8A=B6=E6=98=A0=E5=
=B0=84=E3=80=82 =E5=BD=93=E4=B8=80=E4=B8=AAhw
 =E5=A6=82=E6=9E=9Chwirq=E5=8F=B7=E5=8F=AF=E4=BB=A5=E9=9D=9E=E5=B8=B8=E5=A4=
=A7=EF=BC=8C=E6=A0=91=E7=8A=B6=E6=98=A0=E5=B0=84=E6=98=AF=E4=B8=80=E4=B8=AA=
=E5=BE=88=E5=A5=BD=E7=9A=84=E9=80=89=E6=8B=A9=EF=BC=8C=E5=9B=A0=E4=B8=BA=E5=
=AE=83=E4=B8=8D=E9=9C=80=E8=A6=81=E5=88=86=E9=85=8D=E4=B8=80=E4=B8=AA=E5=92=
=8C=E6=9C=80=E5=A4=A7hwirq
 =E5=8F=B7=E4=B8=80=E6=A0=B7=E5=A4=A7=E7=9A=84=E8=A1=A8=E3=80=82 =E7=BC=BA=E7=
=82=B9=E6=98=AF=EF=BC=8Chwirq=E5=88=B0IRQ=E5=8F=B7=E7=9A=84=E6=9F=A5=E6=89=BE=
=E5=8F=96=E5=86=B3=E4=BA=8E=E8=A1=A8=E4=B8=AD=E6=9C=89=E5=A4=9A=E5=B0=91=E6=
=9D=A1=E7=9B=AE=E3=80=82
=20
-irq_domain_add_tree()=E5=92=8Cirq_domain_create_tree()=E5=9C=A8=E5=8A=9F=E8=
=83=BD=E4=B8=8A=E6=98=AF=E7=AD=89=E4=BB=B7=E7=9A=84=EF=BC=8C=E9=99=A4=E4=BA=
=86=E7=AC=AC=E4=B8=80
-=E4=B8=AA=E5=8F=82=E6=95=B0=E4=B8=8D=E5=90=8C=E2=80=94=E2=80=94=E5=89=8D=E8=
=80=85=E6=8E=A5=E5=8F=97=E4=B8=80=E4=B8=AAOpen Firmware=E7=89=B9=E5=AE=9A=E7=
=9A=84 'struct device_node' =EF=BC=8C=E8=80=8C=E5=90=8E=E8=80=85=E6=8E=A5=E5=
=8F=97
-=E4=B8=80=E4=B8=AA=E6=9B=B4=E9=80=9A=E7=94=A8=E7=9A=84=E6=8A=BD=E8=B1=A1 'st=
ruct fwnode_handle' =E3=80=82
-
 =E5=BE=88=E5=B0=91=E6=9C=89=E9=A9=B1=E5=8A=A8=E5=BA=94=E8=AF=A5=E9=9C=80=E8=
=A6=81=E8=BF=99=E4=B8=AA=E6=98=A0=E5=B0=84=E3=80=82
=20
 =E6=97=A0=E6=98=A0=E5=B0=84
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 952d3c8..62f81bb 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -730,22 +730,6 @@ static inline void msi_device_domain_free_wired(struct i=
rq_domain *domain, unsig
 }
 #endif
=20
-static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_=
node,
-						     const struct irq_domain_ops *ops,
-						     void *host_data)
-{
-	struct irq_domain_info info =3D {
-		.fwnode		=3D of_fwnode_handle(of_node),
-		.hwirq_max	=3D ~0U,
-		.ops		=3D ops,
-		.host_data	=3D host_data,
-	};
-	struct irq_domain *d;
-
-	d =3D irq_domain_instantiate(&info);
-	return IS_ERR(d) ? NULL : d;
-}
-
 static inline struct irq_domain *irq_domain_add_linear(struct device_node *o=
f_node,
 						       unsigned int size,
 						       const struct irq_domain_ops *ops,

