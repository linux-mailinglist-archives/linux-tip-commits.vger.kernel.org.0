Return-Path: <linux-tip-commits+bounces-6957-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7978DBE59BB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 23:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8801A65D13
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117E0231826;
	Thu, 16 Oct 2025 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ajg4I1N/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z7gfrTOW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DF3346BF;
	Thu, 16 Oct 2025 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651597; cv=none; b=nvc90Q7AKs3G75FI+fSlmx2p2Cumzm3Z7Ef1IhDYUBR6PNK55OaxtKCCzGFs/k8a9bI1Xg1sdUZMCAwWytp9ZG5rL74xvV6Ad1yuyBr2rVom6kZ5ustjNS6mJeNX6prGkDvLHckIEry8eNpSaCaNmPVi+gMNlLV+dDaxoSksWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651597; c=relaxed/simple;
	bh=nbjyGsCsHwjIOgAwswA68bpFtw3DfJcGW692Q1LwxTQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kDKEVyIBpSmNVvrxikJwBCYoTDap5PW73uk9zQCgmwK2wRyo5jWrlIVfY9Ro+BMoOv5YSPlnIrcfigDL6BqldwaxwcEikfItneToXPq5WUH+5Z5ezzmwaTD5zilz9/6l+FcwS3PEKvvUGGRBybvG9NK3KsqtR3JRkDX5TcbEvJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ajg4I1N/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z7gfrTOW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 21:53:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760651593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8k3Cqdd6DdCTKtfMuzVYul/L3qAc251dzfRLBtTFNNQ=;
	b=Ajg4I1N/ev0E8ZBingZu3TADggVHjwTOGeQGCWlmlgmimYebQgwGuRIC+bvwo2pUu6PWD/
	vVjeBnL7whaYTxFevCZuQFgTU/J6qwzsD+wah5Gdt59HjhMSp8iGghVwo0wfBhBGNf/Yuu
	FPMc/aDXJBfdSFuYAF432R8lyTDmdrhWb/sWfs71yie4cEXibjEgCeNfDK5m8AtOw+Sqeo
	7FF2EkgVzo3GQcBLLSmSBnEOXOQQ3lHOO0CXrcztNsIORSXqZLIBcGduW5tAZiLQSiUgWr
	BKQPYl3e0xK8Dfq9dLysDl4CT+orTJGpDtxxb1HaR5uj850j3MjPPasKQzDByQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760651593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8k3Cqdd6DdCTKtfMuzVYul/L3qAc251dzfRLBtTFNNQ=;
	b=Z7gfrTOWsA8yCI2kvH7lqTYsqobtbqB8JHhfil0HzVdkSiJSvl2n1FyCnWlFg3JmpHCzwu
	Nb2xOXy7qCFvfPAw==
From: "tip-bot2 for Elena Reshetova" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Enable automatic SVN updates for SGX enclaves
Cc: Elena Reshetova <elena.reshetova@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Nataliia Bondarevska <bondarn@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251016131314.17153-6-elena.reshetova@intel.com>
References: <20251016131314.17153-6-elena.reshetova@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176065159121.709179.14674872837536557005.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     0f2753efc5baff2f0b2a921fe77990c7b12955dc
Gitweb:        https://git.kernel.org/tip/0f2753efc5baff2f0b2a921fe77990c7b12=
955dc
Author:        Elena Reshetova <elena.reshetova@intel.com>
AuthorDate:    Thu, 16 Oct 2025 16:11:08 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Oct 2025 14:42:09 -07:00

x86/sgx: Enable automatic SVN updates for SGX enclaves

=3D=3D Background =3D=3D

ENCLS[EUPDATESVN] is a new SGX instruction [1] which allows enclave
attestation to include information about updated microcode SVN without a
reboot. Before an EUPDATESVN operation can be successful, all SGX memory
(aka. EPC) must be marked as =E2=80=9Cunused=E2=80=9D in the SGX hardware met=
adata
(aka.EPCM). This requirement ensures that no compromised enclave can
survive the EUPDATESVN procedure and provides an opportunity to generate
new cryptographic assets.

=3D=3D Solution =3D=3D

Attempt to execute ENCLS[EUPDATESVN] every time the first file descriptor
is obtained via sgx_(vepc_)open(). In the most common case the microcode
SVN is already up-to-date, and the operation succeeds without updating SVN.

Note: while in such cases the underlying crypto assets are regenerated, it
does not affect enclaves' visible keys obtained via EGETKEY instruction.

If it fails with any other error code than SGX_INSUFFICIENT_ENTROPY, this
is considered unexpected and the *open() returns an error. This should not
happen in practice.

On contrary, SGX_INSUFFICIENT_ENTROPY might happen due to a pressure on the
system's DRNG (RDSEED) and therefore the *open() can be safely retried to
allow normal enclave operation.

[1] Runtime Microcode Updates with Intel Software Guard Extensions,
https://cdrdv2.intel.com/v1/dl/getContent/648682

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Nataliia Bondarevska <bondarn@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index ffc7b94..3eda7e7 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -934,7 +934,7 @@ static int sgx_usage_count;
  * *             entropy in RNG
  * * %-EIO:    - Unexpected error, retries are not advisable
  */
-static int __maybe_unused sgx_update_svn(void)
+static int sgx_update_svn(void)
 {
 	int ret;
=20
@@ -992,14 +992,30 @@ static int __maybe_unused sgx_update_svn(void)
 	return -EIO;
 }
=20
+/* Mutex to ensure no concurrent EPC accesses during EUPDATESVN */
+static DEFINE_MUTEX(sgx_svn_lock);
+
 int sgx_inc_usage_count(void)
 {
+	int ret;
+
+	guard(mutex)(&sgx_svn_lock);
+
+	if (!sgx_usage_count) {
+		ret =3D sgx_update_svn();
+		if (ret)
+			return ret;
+	}
+
+	sgx_usage_count++;
+
 	return 0;
 }
=20
 void sgx_dec_usage_count(void)
 {
-	return;
+	guard(mutex)(&sgx_svn_lock);
+	sgx_usage_count--;
 }
=20
 static int __init sgx_init(void)

