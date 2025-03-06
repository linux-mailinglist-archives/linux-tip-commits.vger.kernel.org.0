Return-Path: <linux-tip-commits+bounces-4025-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0E3A547A4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 11:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465113ADDD5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B0818FC9F;
	Thu,  6 Mar 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AARmeVnF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="evJrcKoq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90B718A6B5;
	Thu,  6 Mar 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256631; cv=none; b=D17QVAW7sW/faUr1B/JNCgPIB11GpfD+3RgmvX7CBIkiHf8T85jp1O35ie8T32sjPfdDvcAHkCJ6tUiXjMH9nnRlrYLU5ZXPebjpwXR8d+x1Tae95Lc9a9wXz0EJB80vRxGAv45clBVFBt2mQ6Jky7mEaXkGRn8w9CjZVq4vXVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256631; c=relaxed/simple;
	bh=J/F2ZyBMgYa7R+5vJPIeIDMUx6CilzLcsleL0j7GwZs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O5Aw4kAWGcUupTeUgD/w4+F66+GRihGpNEEwWES6wLW+NWTSCYvSn+zA+4yqW6RPlfvx69jVguALdBswlpBpgAE2WpmbKT83JjKI1Kh1JjrGAfYRdKZ2ver2SpGoKD4AmeoJ+5KxXK+G4NpRJk7iIXWazuqp8rqqzZQbylzPcCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AARmeVnF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=evJrcKoq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 10:23:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741256627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPDbj7FcFFpSPprZvDLOQJDm32vmo8MSQq14mOONeEI=;
	b=AARmeVnFVnDvvnoFWQRLP+74e1tu+Mk0uYvZYtqN7S8UtO+HlA5SqXboDFJ+oh8UsT2wca
	YE5hTeyAB8x0UNYPeOpPLgW4ZeuQYHpyAlCi2sws4jiHb6hh3OFBxqZLHgBbnXf+yXHmOS
	ny9SXi3jaGZFlJvIZKbeYDDNiWzTlHBNs5oMm75zBc1FaGRj9R8ziB+nkidKJCDj4h8c+/
	Gelp9LBk+5oxzRb7i5fmI8B9QBiWwIYIe5u20jTyvqQFG/BN+OID3eZSqJRplfBsQ/NviG
	veGpbnrJe4FKem0hzyY+2lEquzATSz3n1ujjIbGfc4Ki4qJMNWDQR9odmNg79A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741256627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPDbj7FcFFpSPprZvDLOQJDm32vmo8MSQq14mOONeEI=;
	b=evJrcKoqcv0w5glHbh4FMy9h7rklzXW9gqm+f4KsthVH1/hr/Bp60NZKz/XF0g8yii1duG
	C2eTdfgv3wiN8oBA==
From: "tip-bot2 for Zeng Heng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/olpc: Remove unused variable 'len'
 in olpc_dt_compatible_match()
Cc: Zeng Heng <zengheng4@huawei.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241025074203.1921344-1-zengheng4@huawei.com>
References: <20241025074203.1921344-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174125662677.14745.4766666599934754288.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     ef69de53c46a4b526442f6bc5970fc14f7a0bb32
Gitweb:        https://git.kernel.org/tip/ef69de53c46a4b526442f6bc5970fc14f7a=
0bb32
Author:        Zeng Heng <zengheng4@huawei.com>
AuthorDate:    Fri, 25 Oct 2024 15:42:03 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 11:14:26 +01:00

x86/platform/olpc: Remove unused variable 'len' in olpc_dt_compatible_match()

The following build warning highlights some unused code:

  arch/x86/platform/olpc/olpc_dt.c: In function =E2=80=98olpc_dt_compatible_m=
atch=E2=80=99:
  arch/x86/platform/olpc/olpc_dt.c:222:12: warning: variable =E2=80=98len=E2=
=80=99 set but not used [-Wunused-but-set-variable]

The compiler is right, the local variable 'len' is set but never used,
so remove it.

Fixes: a7a9bacb9a32 ("x86/platform/olpc: Use a correct version when making up=
 a battery node")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241025074203.1921344-1-zengheng4@huawei.com
---
 arch/x86/platform/olpc/olpc_dt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_d=
t.c
index cf5dca2..e108ce7 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -215,13 +215,12 @@ static u32 __init olpc_dt_get_board_revision(void)
 static int __init olpc_dt_compatible_match(phandle node, const char *compat)
 {
 	char buf[64], *p;
-	int plen, len;
+	int plen;
=20
 	plen =3D olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
 	if (plen <=3D 0)
 		return 0;
=20
-	len =3D strlen(compat);
 	for (p =3D buf; p < buf + plen; p +=3D strlen(p) + 1) {
 		if (strcmp(p, compat) =3D=3D 0)
 			return 1;

