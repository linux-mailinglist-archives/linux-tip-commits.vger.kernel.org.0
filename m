Return-Path: <linux-tip-commits+bounces-7366-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5082C5F99A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Nov 2025 00:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CADB35FA15
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 23:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C533101DD;
	Fri, 14 Nov 2025 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aDfQQJW1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n1tX6eP3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8F30FC11;
	Fri, 14 Nov 2025 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763163203; cv=none; b=TQNs5UXae3nZYt5XtDivP2Im5qAFtZCQ87OyAdAiaf1sEmjLiqSJNN2G2kt+rGBz1jl1wFUdmWpboMeMoArF54u/TGW9vnOQIowGHPqdvRXXBb7yz4r1i0+LHgKSALL/QmYj6uzTy+2xSrhcLRSdLclYFL81TYvhtFyr0biVo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763163203; c=relaxed/simple;
	bh=qVnGhK9ddWIbJOCz5pRqDwDNs+cue5my+IyIQYx4m50=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ST3PBPPMmngH8NQWL+RI5Bgx+SYaN1sH5Y9/Vj00N9oANsNFnSkOu194tMel8H3NDaZc7cdtbbp4yX9zRw3WXjM7nmww5iXd7cHlEhpqjkVokHBXSY3msDL5T/M/ERLvvbFpfTWoZ5wouHenfAJcejdv4SJ+sMW0yOWYfzqFRy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aDfQQJW1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n1tX6eP3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 23:33:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763163198;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=l86R6zjMQ2101yTwGspdiVuNfx3zwzGBFu9e/Ls6a3Q=;
	b=aDfQQJW18zkAiLYU1xH7Opbx1U+w0usNhdPY6xle3AJdbewktq+7PUlqKx0oSK6yB8EgT2
	G7cAXeeAbfw65/PN0tTDBsGGj2ZZt8s7yZK5uctdSYiDrglsvD9mIbsBe78w+VO0Y7zet3
	6EKNgJ3JseL+qsuODVsFOFSkrw0bi1ud4/kNMd2P4/Yc8t1ZutzcRoUJoILe5sC4m2kQav
	4s6LGutYEG+2OZgyXMDH2x/bK4OhgEVs0NXPnvD4bCYuKhL3+t/0LKoKo6Yu7b1s+eSfLS
	vWI1tk7UMYW5H6mKKxMnpr6AVzwwNBfr4Q05hRVN2F/V5EKiMprdeh5jWemIPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763163198;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=l86R6zjMQ2101yTwGspdiVuNfx3zwzGBFu9e/Ls6a3Q=;
	b=n1tX6eP3DsUr0mVg7yksasaRw3LVUl1gmkNIEYdgyglUtyymRMYCAM8NV82DLvjVyxxHXw
	UPnJ0P4jJ1Q//RDg==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add kernel-doc descriptions for params passed
 to vDSO user handler
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
Message-ID: <176316319786.498.6814123349698930785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     243ea511fea00572c720199f5b0e00623e9ffc62
Gitweb:        https://git.kernel.org/tip/243ea511fea00572c720199f5b0e00623e9=
ffc62
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Wed, 12 Nov 2025 08:07:05 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 14 Nov 2025 15:30:22 -08:00

x86/sgx: Add kernel-doc descriptions for params passed to vDSO user handler

Add kernel-doc markup for the register parameters passed by the vDSO blob
to the user handler to suppress build warnings, e.g.

  WARNING: arch/x86/include/uapi/asm/sgx.h:157 function parameter 'r8' not
           described in 'sgx_enclave_user_handler_t'

Call out that except for RSP, the registers are undefined on asynchronous
exits as far as the vDSO ABI is concerned.  E.g. the vDSO's exception
handler clobbers RDX, RDI, and RSI, and the kernel doesn't guarantee that
R8 or R9 will be zero (the synthetic value loaded by the CPU).

Closes: https://lore.kernel.org/all/20251106145506.145fc620@canb.auug.org.au
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://patch.msgid.link/20251112160708.1343355-3-seanjc%40google.com
---
 arch/x86/include/uapi/asm/sgx.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index a438ea4..0d408f0 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -143,6 +143,12 @@ struct sgx_enclave_run;
 /**
  * typedef sgx_enclave_user_handler_t - Exit handler function accepted by
  *					__vdso_sgx_enter_enclave()
+ * @rdi:	RDI at the time of EEXIT, undefined on AEX
+ * @rsi:	RSI at the time of EEXIT, undefined on AEX
+ * @rdx:	RDX at the time of EEXIT, undefined on AEX
+ * @rsp:	RSP (untrusted) at the time of EEXIT or AEX
+ * @r8:		R8 at the time of EEXIT, undefined on AEX
+ * @r9:		R9 at the time of EEXIT, undefined on AEX
  * @run:	The run instance given by the caller
  *
  * The register parameters contain the snapshot of their values at enclave

