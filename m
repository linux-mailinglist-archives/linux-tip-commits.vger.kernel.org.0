Return-Path: <linux-tip-commits+bounces-7367-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A8C5F99D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Nov 2025 00:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6EB135FA65
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 23:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D81310620;
	Fri, 14 Nov 2025 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nc7qlhNd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5s7w/p/L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0E30FC0E;
	Fri, 14 Nov 2025 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763163203; cv=none; b=TFKfkSPAmNcQA2MP6t/5wIWBf3LEXnRxwKEhVgWpRVEhUWslAsdQbyh/Sf6uGRFE9bUpr0OISps1nUPp2ICUNwTuY3I5axQQwJSiT67LdMLaWolNbWVRmGikgWhcHn7HZHhr6Dp4/S0lEaukX764opRuJgMF2DXPKKpYBuuSWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763163203; c=relaxed/simple;
	bh=Gukm459S9MSL1+D9QIrvhPU8T6jkYmOi+6bFQm/ZD6Q=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=f0yT3YrlcUmykykvMYb49cuZ8cY/5eakl724ZszAzwwGzbF7o1zeQycCOqS/b79VbIFwdXAPxbDUi9u5ogo12k0bFc7iJ5/INWVZAiK0hXLxnzMlx23wGWXHk+95VCmFO8XuCHX34rOXhzNdzkIZoAS/dMkRhbvcSZimtFTQBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nc7qlhNd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5s7w/p/L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 23:33:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763163200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=HRCAOocFaHbQDjotfANJ9gatxp4IanPlDX09KqzJjJw=;
	b=nc7qlhNd1T+SnY1MwMRz6HbXsl7mG2cV4JiBuHEiNt76Y3MPqGu+D4jFRLmrm/od3HHigJ
	aHGfPUxpDkh+U602jLnlf3/uXh+AGm5jsIHI3p9e2cfU4nqfrfft1LMlQV3Nds8OpFz8Q0
	yJQN24Jfl+96d3BOGXYc15jCXqgCXeOoQeMlMU+UU3uvp2TIt913K7cWzlUTUp8+UQKK8/
	71mCevvSA9G629VwuzoCmOZzsLOG4loZM70VUwK9wB7YgXA52aYCzgGvHEMDfQfaHy1j/X
	SIPcjXW3i+NiAG+XtxRqTu1Taz6wmBZx3zHsHLS+aPrWppqV70Fb9kKjMaRqCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763163200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=HRCAOocFaHbQDjotfANJ9gatxp4IanPlDX09KqzJjJw=;
	b=5s7w/p/LCCd8iXGlEBDW/dKx9vRsAgP6o6Y3Z81QzViGByH3QjfewjCPC0l68NbE7zmtmA
	uZxDPiKvPEX3AUDQ==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add a missing colon in kernel-doc markup for
 "struct sgx_enclave_run"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176316319884.498.5148739863226494963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     75801ca620a6ba9f3da7d4e3d3a8ad10811c579e
Gitweb:        https://git.kernel.org/tip/75801ca620a6ba9f3da7d4e3d3a8ad10811=
c579e
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Wed, 12 Nov 2025 08:07:04 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 14 Nov 2025 15:30:13 -08:00

x86/sgx: Add a missing colon in kernel-doc markup for "struct sgx_enclave_run"

Add a missing ':' for the description of sgx_enclave_run.reserved so that
documentation for the member is correctly generated:

  WARNING: arch/x86/include/uapi/asm/sgx.h:184 struct member 'reserved' not
  described in 'sgx_enclave_run'

Closes: https://lore.kernel.org/all/20251106145506.145fc620@canb.auug.org.au
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://patch.msgid.link/20251112160708.1343355-2-seanjc%40google.com
---
 arch/x86/include/uapi/asm/sgx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 2dd35bb..a438ea4 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -166,7 +166,7 @@ typedef int (*sgx_enclave_user_handler_t)(long rdi, long =
rsi, long rdx,
  * @exception_addr:		The address that triggered the exception
  * @user_handler:		User provided callback run on exception
  * @user_data:			Data passed to the user handler
- * @reserved			Reserved for future extensions
+ * @reserved:			Reserved for future extensions
  *
  * If @user_handler is provided, the handler will be invoked on all return p=
aths
  * of the normal flow.  The user handler may transfer control, e.g. via a

