Return-Path: <linux-tip-commits+bounces-6959-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D83BE59CA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 23:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E985445F1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAA42E6135;
	Thu, 16 Oct 2025 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2m6/sesW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLET+/lq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907A3346BF;
	Thu, 16 Oct 2025 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651602; cv=none; b=ficalFbG3xRVPXGMjYBkIngZTN6atzJPRp/mhG4J65KU7hxy58KeeaUPYnJTvRHEPuUIT7ye5fgD47cdov0j/y/dBA/vgvZxf3W6yAUE1zqIGwo1hPuBHcYwvpHFR+QkpiS3Ic2eNxRtmYeD99o1ylvTpVORpjxIP6E4HkQXLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651602; c=relaxed/simple;
	bh=mE4rsHZ8aULRRyhgmf1dEibM9tSCA0xwaJ2yHQ/HmeU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j6Ddtsw3zR0YKYO+4Lxt5IfSqpkg3KM6zHVdLj3UJSPjiXbwtDfB+iG6Ngsx+BLzlMlxHhjzL5/NhKixUKO1p5vjf+boauA0e4QG2jI8l1cXBDEjPijWfw4MA32LliqVz5+yKK1Pk5ry6Yg2YjlU4HVN7RYLmyI81PITChzK4Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2m6/sesW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLET+/lq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 21:53:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760651598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ouj/VGyzkjY6PXFfJraf6kmW1Sa1B5x+wojtHF4t8I=;
	b=2m6/sesWDoTasUgeL2rTP4g/hN9ZoveP7qGYEbKJ8vuka71Emar7u+abESxjY1q0Kcene5
	6Z+5JzbKrO06PWzVDi6x8ZgJkxi3Y4Jyw7egEcA8PdOemx+QVo3HFbdvTAq6fuyW2Dy+pe
	cxdRBGy1l02OSleQ7cNqK8OGpaTqejIqhvpivHfhgE+mnMoQQczDPDT4jn92APHVQAVUQg
	JsNabPIQG+pLsvOUnnnUwKymA9CKbeOLQLp/ajkr1PQ6lSxozaF0IqvRgxjGu48Q+JKmTO
	P+KEyukGau6MSkNxuDuBB/ACqO7R/MDCnX0Qmy/KwpCvUXtJlFFtJKu6gsTmdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760651598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ouj/VGyzkjY6PXFfJraf6kmW1Sa1B5x+wojtHF4t8I=;
	b=NLET+/lqxMjdAZGxEo9NQyfVC/khUAcW3n4yEuLUEDAK5IqIgdFXCKS2uJArmFnORvKWlQ
	5cbh/FP4/k/49KDA==
From: "tip-bot2 for Elena Reshetova" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sgx] x86/sgx: Define error codes for use by ENCLS[EUPDATESVN]
Cc: Elena Reshetova <elena.reshetova@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Nataliia Bondarevska <bondarn@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251016131314.17153-4-elena.reshetova@intel.com>
References: <20251016131314.17153-4-elena.reshetova@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176065159743.709179.17232165280940116721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     7b502832ee69274ce88faa5d64a339f8760b50bf
Gitweb:        https://git.kernel.org/tip/7b502832ee69274ce88faa5d64a339f8760=
b50bf
Author:        Elena Reshetova <elena.reshetova@intel.com>
AuthorDate:    Thu, 16 Oct 2025 16:11:06 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Oct 2025 14:42:09 -07:00

x86/sgx: Define error codes for use by ENCLS[EUPDATESVN]

Add error codes for ENCLS[EUPDATESVN], then SGX CPUSVN update process can
know the execution state of EUPDATESVN and notify userspace.

EUPDATESVN will be called when no active SGX users is guaranteed. Only add
the error codes that can legally happen. E.g., it could also fail due to
"SGX not ready" when there's SGX users but it wouldn't happen in this
implementation.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Nataliia Bondarevska <bondarn@google.com>
---
 arch/x86/include/asm/sgx.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 6a00697..73348cf 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -73,6 +73,10 @@ enum sgx_encls_function {
  *				public key does not match IA32_SGXLEPUBKEYHASH.
  * %SGX_PAGE_NOT_MODIFIABLE:	The EPC page cannot be modified because it
  *				is in the PENDING or MODIFIED state.
+ * %SGX_INSUFFICIENT_ENTROPY:	Insufficient entropy in RNG.
+ * %SGX_NO_UPDATE:		EUPDATESVN could not update the CPUSVN because the
+ *				current SVN was not newer than CPUSVN. This is the most
+ *				common error code returned by EUPDATESVN.
  * %SGX_UNMASKED_EVENT:		An unmasked event, e.g. INTR, was received
  */
 enum sgx_return_code {
@@ -81,6 +85,8 @@ enum sgx_return_code {
 	SGX_CHILD_PRESENT		=3D 13,
 	SGX_INVALID_EINITTOKEN		=3D 16,
 	SGX_PAGE_NOT_MODIFIABLE		=3D 20,
+	SGX_INSUFFICIENT_ENTROPY	=3D 29,
+	SGX_NO_UPDATE			=3D 31,
 	SGX_UNMASKED_EVENT		=3D 128,
 };
=20

