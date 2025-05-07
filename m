Return-Path: <linux-tip-commits+bounces-5434-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E276EAAE116
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B727AB8E5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372A328B3F5;
	Wed,  7 May 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NQS4Wzaq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MFjvIV9G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589AF28AAEF;
	Wed,  7 May 2025 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625458; cv=none; b=lGgsnxnjqFNMnN/cwBpPsHsjhCaZeKRk1Slz/leqFfhFfYZ+68xs0PiUr5NltaNUVUNLQyLjeIqhLEk14ZBX4mU3Qd6Rho30Pp026rp1TYzSBRehvqC9xuqB3aoIz0xI2VbUqdGTor8T9piR6sNYnswg9QMhBqF2S5qdI/Ort3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625458; c=relaxed/simple;
	bh=LsL9cbpd3jMqnnLgAKp2gdukQV8UhYgm1mEgbANwAq0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uenQVhAQ0IFnb+hieg3/JNN3QRh8w70ZbrJeoso2rlC8QWzcWLWlMt2xU4VgXvatcku9BNJrqkbWNq0WNGpVhWVVf/YfTKqweXnU2nSM0/XgW0iXhKqPD3y36tBWeYvw97UrTuKKlc1ojxH5ivz3TKmXoHxIAlJuK3S998QSjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NQS4Wzaq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MFjvIV9G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWTin31wFXudk/l47HBJ3sZF/GvMvNV6HyzGIPy26dA=;
	b=NQS4WzaqO6Cwfj/VJL9HMhen5tkme5vKGxdqAU25wqzrE9ZNDE5+5QqlHVh5zbux8OhKjm
	5meFchoyzSEFTahfNKMUWqLf+fQ/fs5iUIUepRWZbBaM+GQnpHtKyiz9X3dVgT855JnWaC
	z3Ict4iFurY9/u7JynG9B8mkoQjG1cKRPmomSQdYTimkWA9NCdz++A0R0SOHLfo3ZuCyV5
	qs+Ij77iKH2dX8lpY+faSeuLR17DUxu0CdxkOOuCUJBJ0jzj31JqFV/aqqZTQn1ReQyNfx
	swDcF7lkrYkZ3YVVC1zMOmSewDQVjmN0vB8qZ2YB1ta9vmdceB8ZMycqP/nazA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWTin31wFXudk/l47HBJ3sZF/GvMvNV6HyzGIPy26dA=;
	b=MFjvIV9GCgnYLIT+GmmiSUTcUiRXQlLyDDCr782VpmcajEfQ+jv3kUbitL6jSZnYE5k+gy
	mMtUTJJhyIaVbeCA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups]
 _PATCH_v2_39_57_irqdomain_ppc_Switch_irq_domain_add_nomap_to_use_fwnode
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-40-jirislaby@kernel.org>
References: <20250319092951.37667-40-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662545421.406.3180191986559150826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     2842da7b2b13c46327fe221a335e08efd35edba4
Gitweb:        https://git.kernel.org/tip/2842da7b2b13c46327fe221a335e08efd35=
edba4
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:41 +02:00

_PATCH_v2_39_57_irqdomain_ppc_Switch_irq_domain_add_nomap_to_use_fwnode

All irq_domain_add_*() functions are going away. PowerPC is the only
user of irq_domain_add_nomap() and there is no irq_domain_create_nomap()
complement.

Therefore, to align with the rest of the kernel, rename
irq_domain_add_nomap() to irq_domain_create_nomap() and accept a
fwnode_handle instead of a device_node.

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-40-jirislaby@kernel.org


---
 Documentation/core-api/irq/irq-domain.rst                    | 2 +-
 Documentation/translations/zh_CN/core-api/irq/irq-domain.rst | 2 +-
 arch/powerpc/platforms/powermac/smp.c                        | 2 +-
 arch/powerpc/platforms/ps3/interrupt.c                       | 2 +-
 include/linux/irqdomain.h                                    | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-a=
pi/irq/irq-domain.rst
index f88a6ee..44f4ba5 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -141,7 +141,7 @@ No Map
=20
 ::
=20
-	irq_domain_add_nomap()
+	irq_domain_create_nomap()
=20
 The No Map mapping is to be used when the hwirq number is
 programmable in the hardware.  In this case it is best to program the
diff --git a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst b/D=
ocumentation/translations/zh_CN/core-api/irq/irq-domain.rst
index 9174fce..ecb23cf 100644
--- a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
+++ b/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
@@ -124,7 +124,7 @@ irq_domain_add_tree()=E5=92=8Cirq_domain_create_tree()=E5=
=9C=A8=E5=8A=9F=E8=83=BD=E4=B8=8A=E6=98=AF=E7=AD=89=E4=BB=B7=E7=9A=84=EF=BC=
=8C=E9=99=A4=EF=BF=BD
=20
 ::
=20
-	irq_domain_add_nomap()
+	irq_domain_create_nomap()
=20
 =E5=BD=93=E7=A1=AC=E4=BB=B6=E4=B8=AD=E7=9A=84hwirq=E5=8F=B7=E6=98=AF=E5=8F=
=AF=E7=BC=96=E7=A8=8B=E7=9A=84=E6=97=B6=E5=80=99=EF=BC=8C=E5=B0=B1=E5=8F=AF=
=E4=BB=A5=E9=87=87=E7=94=A8=E6=97=A0=E6=98=A0=E5=B0=84=E7=B1=BB=E5=9E=8B=E3=
=80=82 =E5=9C=A8=E8=BF=99=E7=A7=8D=E6=83=85=E5=86=B5=E4=B8=8B=EF=BC=8C=E6=9C=
=80=E5=A5=BD=E5=B0=86
 Linux IRQ=E5=8F=B7=E7=BC=96=E5=85=A5=E7=A1=AC=E4=BB=B6=E6=9C=AC=E8=BA=AB=EF=
=BC=8C=E8=BF=99=E6=A0=B7=E5=B0=B1=E4=B8=8D=E9=9C=80=E8=A6=81=E6=98=A0=E5=B0=
=84=E4=BA=86=E3=80=82 =E8=B0=83=E7=94=A8irq_create_direct_mapping()
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/p=
owermac/smp.c
index 09e7fe2..88e92af 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -190,7 +190,7 @@ static int __init psurge_secondary_ipi_init(void)
 {
 	int rc =3D -ENOMEM;
=20
-	psurge_host =3D irq_domain_add_nomap(NULL, ~0, &psurge_host_ops, NULL);
+	psurge_host =3D irq_domain_create_nomap(NULL, ~0, &psurge_host_ops, NULL);
=20
 	if (psurge_host)
 		psurge_secondary_virq =3D irq_create_direct_mapping(psurge_host);
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/=
ps3/interrupt.c
index 95e96bd..a4ad4b4 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -743,7 +743,7 @@ void __init ps3_init_IRQ(void)
 	unsigned cpu;
 	struct irq_domain *host;
=20
-	host =3D irq_domain_add_nomap(NULL, PS3_PLUG_MAX + 1, &ps3_host_ops, NULL);
+	host =3D irq_domain_create_nomap(NULL, PS3_PLUG_MAX + 1, &ps3_host_ops, NUL=
L);
 	irq_set_default_domain(host);
=20
 	for_each_possible_cpu(cpu) {
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 6e9a5ec..f3c79f9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -431,13 +431,13 @@ static inline struct irq_domain *irq_domain_add_linear(=
struct device_node *of_no
 }
=20
 #ifdef CONFIG_IRQ_DOMAIN_NOMAP
-static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of=
_node,
+static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handl=
e *fwnode,
 					 unsigned int max_irq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
 	struct irq_domain_info info =3D {
-		.fwnode		=3D of_fwnode_handle(of_node),
+		.fwnode		=3D fwnode,
 		.hwirq_max	=3D max_irq,
 		.direct_max	=3D max_irq,
 		.ops		=3D ops,

