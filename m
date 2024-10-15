Return-Path: <linux-tip-commits+bounces-2438-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB6B99F21F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767A3283F58
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA01F6692;
	Tue, 15 Oct 2024 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qKxy8r7K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4zYzRjZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712701EF092;
	Tue, 15 Oct 2024 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007881; cv=none; b=htTnbfeQb23iM8GGaLOuH1uovOUMeIixJ558Crnd74w6shq4dW1WvkCaguMt/I/xcGW2nRB+jauQ8/9+w9hgDuULcQQbgo4E+lfv4Iq2gzBKCS+JFCnlSkeV8vIyQZAZ/fzN6VZA/VT4y5jyQw+SZMmGoOEK7NL6UT9eLDyhN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007881; c=relaxed/simple;
	bh=dL9ZnbrFys0YJkYq0dw1T2eFpMfz/6h7FD7gPMIV4mU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p27JUi14p9pi8XbThPSVAxxPguvyqXMZMEZjYTPzZpljwuhu4WYNGBuK3WS0Lh2qbW59VvoSt+sVSBGVaLhpApUKT1Zx/+UxKrRKHpjDdlv/6LJ/oUJ3WSFv1tXuuyIGbd6gmwiSPmpt9aZWMyN15ZsdJo2Sp5yo2Nt1LfUGDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qKxy8r7K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J4zYzRjZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:57:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729007878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twsWFzBRq5udPjJGgCfI8bm1DwAa0+++55eZ2BmTNU8=;
	b=qKxy8r7K/levp34RiJkeI7mrMMSF8u2fpjkQM6BlyR2yb8eVzuDuFSqYG3dibqEPrpytZp
	ZzZRwS5WWt/tqxFTxh/2JRFYVrO84m8RX9daPKKOkJLK7G2Rd5tiyM9cY3gXrBavax+E4L
	rnfs7+NI5vNrK7NEaLInt9yzlFTXeU44evLKb9JyKyFmqcw2MKyUM+9ACNwiN89n3oQPP+
	N0pcBEhBcrUojseeMKt5qXiZd56ItNPKlxWA6QqxiaYDPj8CbFeTZNDej47+0kXvZ7CDkC
	7h5MhKyYZDdjLErdsRkX9iNSFFIzdnHvlOB1pbAUmkOb3xPvMOQ/Sf38XsoU2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729007878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twsWFzBRq5udPjJGgCfI8bm1DwAa0+++55eZ2BmTNU8=;
	b=J4zYzRjZvIGJaHBLZ9CjBpNpSNGp+e3bE22kQWKHhR2eT4iBZB62ppZgJ4TbqAs5bdvHtn
	QR+NB7kN+ZRDetAw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] riscv: vdso: Remove timekeeper include
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20241010-vdso-generic-arch_update_vsyscall-v1-5-7fe5a3ea4382@linutronix.de>
References:
 <20241010-vdso-generic-arch_update_vsyscall-v1-5-7fe5a3ea4382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900787810.1442.7825150152039861453.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     930916d85a0958827d5150bb506044424adadf21
Gitweb:        https://git.kernel.org/tip/930916d85a0958827d5150bb506044424ad=
adf21
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 17:44:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:50:29 +02:00

riscv: vdso: Remove timekeeper include

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Also drop the comment which is out of date and in the wrong place.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-arch_update_vsyscall-=
v1-5-7fe5a3ea4382@linutronix.de

---
 arch/riscv/include/asm/vdso/vsyscall.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/include/asm/vdso/vsyscall.h b/arch/riscv/include/asm/=
vdso/vsyscall.h
index 82fd5d8..e8a9c4b 100644
--- a/arch/riscv/include/asm/vdso/vsyscall.h
+++ b/arch/riscv/include/asm/vdso/vsyscall.h
@@ -4,14 +4,10 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
=20
 extern struct vdso_data *vdso_data;
=20
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
 static __always_inline struct vdso_data *__riscv_get_k_vdso_data(void)
 {
 	return vdso_data;

