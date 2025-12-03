Return-Path: <linux-tip-commits+bounces-7586-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6227CA11D0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 19:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FE3831C0D73
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1182B30B525;
	Wed,  3 Dec 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Go/k0y81";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wn4v/t9l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5350D381C4;
	Wed,  3 Dec 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784222; cv=none; b=dzN1w9EELPoBgQWXcpwdvemddc/LRrLl3NVWFn2pJvvNFMbdSEm4hYNWuzag1yqjZ2SfHCwVPc/0cV9rLZRb5PmYRfT0P1LzDzIeaE/pyFgLr7CGw6pqUCyv4j3fQa4NhSUIO+pP4cbCQDgWxy3Z7yz4GMmXhho7cEPmjvFjJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784222; c=relaxed/simple;
	bh=JH25EL+n5jxpqs5wUQpF2KpEByEicF1qpyLF9LwdCDY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Z++HsZA4JRyHbrjHn5LqRFKsh0kMsRsukv7L5yBmtn8802+T0FDoRUIbtV2H89Ca85fLmBO8SYKq8pRfSigjGdWoPX20GpyrbS1afMyghltENB0MIrLEVxGF4GAiuHJfqzwtVQwrSt7nPptZwrug7Wgy8cpJCt4s9NJ+5sx2KaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Go/k0y81; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wn4v/t9l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 17:50:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764784218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CB+OaS0Fv0cneUcnUNQ08hHPpB9WvKjOUqfnJInUy1U=;
	b=Go/k0y81TIIQh3sXjRWQ19E3CHEBL+tNSEu54nFylKmTOLUkP3b0zQwm6kfR/DqAIPw2Nh
	ZFUXR0c/9pTTs0B7519D0U1Cnob1xqxLTzjlV/lRT2ZKsELJ1Qt/1iPSJifGQpAMAEptDN
	zrwzT+YGBQEDWtl+E64LM+VNzZiKMRj+ArjdYw1zBjQADbIU3+Z5vstu3xR8UQPZpQmjLe
	eFsySsLBqkbuSi1RGICXtag/336TPS3y2xSfFPuatbAfMpUPsKtHBtLDiNMjQcI71FvDpY
	OSdi/RBtfQPCHyaQUqScY1O1tWiPoyvsQUWTBWmNB7LS2FmjU2wdJxw5jYq/GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764784218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CB+OaS0Fv0cneUcnUNQ08hHPpB9WvKjOUqfnJInUy1U=;
	b=Wn4v/t9lYAFqdXMY9RoNK12y0lkfhPg1g4dDoJCQney0tFheW2llNR+WLfUrYecyXTdxG6
	ArBoCTvZpvj2gzDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/Documentation: Spell 'ID' consistently
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478421694.498.3076028710849148538.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c7957da77708c74a95d60340c6d3c1a3617cd248
Gitweb:        https://git.kernel.org/tip/c7957da77708c74a95d60340c6d3c1a3617=
cd248
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 03 Dec 2025 18:25:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 18:49:00 +01:00

x86/boot/Documentation: Spell 'ID' consistently

The bootloader ID specification text uses 2 capitalization
variants for the same thing: 'id', 'ids', 'ID' and 'IDs'.

Use 'ID/IDs' consistently.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
---
 Documentation/arch/x86/boot.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 77e6163..b0f648b 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -416,7 +416,7 @@ Offset/size:	0x210/1
 Protocol:	2.00+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
=20
-  If your boot loader has an assigned id (see table below), enter
+  If your boot loader has an assigned ID (see table below), enter
   0xTV here, where T is an identifier for the boot loader and V is
   a version number.  Otherwise, enter 0xFF here.
=20
@@ -431,7 +431,7 @@ Protocol:	2.00+
    ext_loader_type <- 0x05
    ext_loader_ver  <- 0x23
=20
-  Assigned boot loader ids (hexadecimal):
+  Assigned boot loader IDs (hexadecimal):
=20
 	=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 	0  LILO

