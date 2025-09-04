Return-Path: <linux-tip-commits+bounces-6442-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 897BFB4372D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E591C275B5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8692F28F7;
	Thu,  4 Sep 2025 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DG8uOl5U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J/H/My13"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571F292938;
	Thu,  4 Sep 2025 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978338; cv=none; b=kMs95aUyHzTwWW1JDNx5gkx0XSIR3hSWNLcDlGadz5bEzdJK8YSAOQKGnpKlV9PfTLVPFG2cIMcNXkATNcqnT18l7SzL/Z5SgJr/8z82X4e1eTMtnZOZcdOe2uT5jtELzEOi1dBYs2XUtGN0E0thdNWaTqWL8NWHljNCRCha9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978338; c=relaxed/simple;
	bh=Hvq4rJelR6qiCkiB3UrcpIVSJ483RFXRYunq/9Mhlc8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gfLfGpyjiuIq27Hab3laEGIAb8dtll471ZQ+HEO1NCZq2PENuu1Kvw1EmYwF5ahzYRAT5R/lC0X9BvSH1pKfaBX4Vu0mUv/wWaX/+4DU2jDVIFexXKOD6fDvFHTlM3rGRm7buj66arL3fmpz0AnA59AnvVwclYBrdD7O7VGehNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DG8uOl5U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J/H/My13; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:32:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756978334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4J5xFuhr9lm5zd8RwBp6iVTilnYTJYj+YLFCLsOJOw=;
	b=DG8uOl5UHndIU1ri30qMQ3qErCLJgFvHDkCJfUn9GCWgKyiGFTJETkF9wMznGm0aIdFtXI
	LBsrcd1ANRv9/h5jstHc4WT2EBBKZ6U4qRYsg7lz1t21RcPzTj/Km5tS0ClM9xm6uHewB4
	+TrEHezyl1C69NEKvFdMTry+aE1ZyRt6daFiEHtuOOx5b4DdczpGAU1BAIvSztdp9DTObm
	GEdHQH2xWH8BI55YgGePdz4VwRSyB3/L2+DbA93nTatTcTU7eHpUhcxuVa7SQF1Tc+zzv/
	w/nTJBEs6dG/b1eMUbDz42JOgAbQ8tgBaGC+YCuSLbRvPhH9qcbPolD3nVeiPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756978334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4J5xFuhr9lm5zd8RwBp6iVTilnYTJYj+YLFCLsOJOw=;
	b=J/H/My13WK8vxP1hdYG37I/ewNZ/Cqtid6UVnAsnlpBBm+P8aFgUA9cMKblW0F6zFjx/FX
	t6RSIiPr8rIKPSCw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Gate VDSO_GETRANDOM behind HAVE_GENERIC_VDSO
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250826-vdso-cleanups-v1-11-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-11-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697833054.1920.423536567264335155.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     258b37c6e626625fe441e16ab90e6a542a66eaee
Gitweb:        https://git.kernel.org/tip/258b37c6e626625fe441e16ab90e6a542a6=
6eaee
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 26 Aug 2025 08:17:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:23:51 +02:00

vdso: Gate VDSO_GETRANDOM behind HAVE_GENERIC_VDSO

All architectures which want to implement getrandom() in the vDSO need to
use the generic vDSO library.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250826-vdso-cleanups-v1-11-d9b65750e49f@l=
inutronix.de

---
 lib/vdso/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 3d2c2b9..db87ba3 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -19,9 +19,9 @@ config GENERIC_VDSO_OVERFLOW_PROTECT
 	  time getter functions for the price of an extra conditional
 	  in the hotpath.
=20
-endif
-
 config VDSO_GETRANDOM
 	bool
 	help
 	  Selected by architectures that support vDSO getrandom().
+
+endif

