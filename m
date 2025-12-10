Return-Path: <linux-tip-commits+bounces-7626-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BC7CB24B1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 08:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4DDF3030397
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A9E2E0934;
	Wed, 10 Dec 2025 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wZVaySIQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RyzRMFZI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3D311967;
	Wed, 10 Dec 2025 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765352454; cv=none; b=nUGfqS67v9tGkV/GaA6nKhHPQagSPKar9hFsB4krD+UvJif3ITHAudRXJJa1O9FD1Pd7febANcP9pi9I1q8bUa7ky7Ke4H9yGBrM4aKmbsNVztKFnNQpr0bCGnP0Lx0pSIQ9H9NbKgwWLOX/Tbeh+f9NVSo55LpgXRqYgAAwyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765352454; c=relaxed/simple;
	bh=3BpipW1DJHgdNtdbANo4FQ72Hy5+NbR06IY87qoIbCk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jviSBFNcQ/a1GQ1auIwm+rvbU12rxHdAWR8guGN8TZZUDomBJ5ofnUZZYHyuKOVUg3spJ6pxWw1dj/s5fc+bwcKRTqQBkZznEXG78wUsCWqfMJxTbPN+fbRw++XPElmyBn3VJjgFSsBCUsV3t0Alrqgk6oyH0gv3lOtcBE2JKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wZVaySIQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RyzRMFZI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Dec 2025 07:40:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765352450;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c047LKzRLZgAKsVHXcEP0T0oj+PI2f3Q0bJ8+MCvLBM=;
	b=wZVaySIQkRREDGiCNk1UanKnP60kVy/tKtegDBCa9CEdtmkAIMpk0CZX00IEoWNNJqEyv1
	Og4tEyi1drbd3LFDVzec8aIkTONHWj9rCEZyjCTGTA/ORICBu94G0XQXQzW931RehhUAsT
	SjnG9YwX8x/BTTJYt1qAzajW3M/e7PeBSnW0/peVzy6qhlnQT6UT5BAa+yY2zF8CSIkL6g
	ctKDDcH8sApqpRGhrWAVLJ+v0gWpuestdxdJp+6vSiegOnnG2+4APgyS2LvLGRxifxIIzd
	v0SJhSeQl1jfD52Ix6WO5KziZi7HxCSDy8jQiGFjW67c3r3YqmDSutdeUtnT8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765352450;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c047LKzRLZgAKsVHXcEP0T0oj+PI2f3Q0bJ8+MCvLBM=;
	b=RyzRMFZIQPJIZ+Q3xzEUbMdLVLi4OC7V4M3HnZ3e+3nsWDGs8V3Ugv2NNaOrXT4pHleKsO
	pqxivi/ZPwWhm1Dw==
From: "tip-bot2 for Swaraj Gaikwad" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/Documentation: Fix htmldocs build warning
 due to malformed table in boot.rst
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251210092814.9986-1-swarajgaikwad1925@gmail.com>
References: <20251210092814.9986-1-swarajgaikwad1925@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176535244893.498.10934536472150900702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5288176a541215ba48d38fb74bb619e64d4d9bab
Gitweb:        https://git.kernel.org/tip/5288176a541215ba48d38fb74bb619e64d4=
d9bab
Author:        Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
AuthorDate:    Wed, 10 Dec 2025 09:28:14=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Dec 2025 08:34:38 +01:00

x86/boot/Documentation: Fix htmldocs build warning due to malformed table in =
boot.rst

Sphinx reports htmldocs warnings:

  Documentation/arch/x86/boot.rst:437: ERROR: Malformed table.
  Text in column margin in table line 2.

The table header defined the first column width as 2 characters ("=3D=3D"),
which is too narrow for entries like "0x10" and "0x13". This caused the
text to spill into the margin, triggering a docutils parsing failure.

Fix it by extending the first column of assigned boot loader ID to 4
characters ("=3D=3D=3D=3D") to fit the widest entries.

Fixes: 1c3377bee212 ("x86/boot/Documentation: Prefix hexadecimal literals wit=
h 0x")
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://patch.msgid.link/20251210092814.9986-1-swarajgaikwad1925@gmail.=
com
---
 Documentation/arch/x86/boot.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 6d36ce8..18574f0 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -433,7 +433,7 @@ Protocol:	2.00+
=20
   Assigned boot loader IDs:
=20
-	=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+	=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 	0x0  LILO
 	     (0x00 reserved for pre-2.00 bootloader)
 	0x1  Loadlin
@@ -456,7 +456,7 @@ Protocol:	2.00+
 	     <http://sebastian-plotz.blogspot.de>
 	0x12 OVMF UEFI virtualization stack
 	0x13 barebox
-	=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+	=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
   Please contact <hpa@zytor.com> if you need a bootloader ID value assigned.
=20

