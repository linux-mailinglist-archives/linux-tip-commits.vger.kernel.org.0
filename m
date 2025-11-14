Return-Path: <linux-tip-commits+bounces-7363-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D1902C5F988
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Nov 2025 00:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B385360A9C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 23:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3467B30F53E;
	Fri, 14 Nov 2025 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IJ9sNZ4j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ebu0GB1T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4AF30DD0E;
	Fri, 14 Nov 2025 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763163200; cv=none; b=PaxX9Xa+P1Jb0Pi8x76Qp5LR4vrg3Vi9M6MY+CAeBgx6VNDDzXrrkq9yw/NQPQxG5Gr0JkEjhu4vpI/V/q/1kKVFUgFrrTswTl1ZyItNWrOdDa0D0GIBFM95XnBhdjcq5ibSekkzIseb9d7MfmNk1qUFXev0Gz6VYoqnUZNh1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763163200; c=relaxed/simple;
	bh=p3QKne3V0hsH4s6GQo/oVeVxzieceKQAej4BP3fm6R4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=N5lt+aUE9UnxYpDfatc5xD4fIQikB93mDH9tkkZ1I6oLCKHoAAvYl1hJsK+oY8PHwCjzlUu0//rJBASLmsOIImS48+QqE14skZoPFL1WqjuBP+VPEL9jCQB4UrvwzwZJcNWXDtqkLSY1JKAd/br3/L1jVRp+9ILCuNX2nQajjkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IJ9sNZ4j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ebu0GB1T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 23:33:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763163196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=SAgLF+zXSACOE67c/G24fpSWMOEIeH9AXhCYVhrvS/c=;
	b=IJ9sNZ4juACtYhYHnUM4RAMOlnpuE4FqqlSRlsMjT9eFkcirijKZntam4zzuaruUlDCAe4
	o6GMiRf7lwqbW/ISDbpD/klYb1ArBG7I4W/Zl3cmHU9Phw5EwUlbYqRJuD2OWi3y/ogqMg
	infxIi0lRRRXdwE01bbM6jqG0Mat3uWKk0SC9F+IsuaD9gr0GUccWrA9UFTCxs7Ln4Rf99
	n30YZnTQqHGsJYzJmw1AnanaMw0wdRuPAVXFwP5p9dgCscGxdIhoqKpW3xX7+QT7if+srb
	xCR44gZniWzSsLRh6U0nmmyAUf3NHWU44jh6ubshdRcaRL/24AYOzPD0xgboEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763163196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=SAgLF+zXSACOE67c/G24fpSWMOEIeH9AXhCYVhrvS/c=;
	b=Ebu0GB1T+N4sUEfGxSU/CrdHtU/D5w/cg+XoK2TuwFlaeyNJGdSRSJj7eS0X648jf9anm9
	VHKYn3e0xVfCo6AA==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Fix a typo in the kernel-doc comment for enum
 sgx_attribute
Cc: Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176316319463.498.17155748145338277533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     f2f22721aca46cebb63c589eefda843721908833
Gitweb:        https://git.kernel.org/tip/f2f22721aca46cebb63c589eefda8437219=
08833
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Wed, 12 Nov 2025 08:07:08 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 14 Nov 2025 15:30:32 -08:00

x86/sgx: Fix a typo in the kernel-doc comment for enum sgx_attribute

Use the exact enum name when documenting "enum sgx_attribute" to fix a
warning if the file is fed into kernel-doc processing:

  WARNING: ./arch/x86/include/asm/sgx.h:139 expecting prototype for enum
           sgx_attributes. Prototype was for enum sgx_attribute instead

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://patch.msgid.link/20251112160708.1343355-6-seanjc%40google.com
---
 arch/x86/include/asm/sgx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 3c90cae..0495845 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -112,7 +112,7 @@ enum sgx_miscselect {
 #define SGX_SSA_MISC_EXINFO_SIZE	16
=20
 /**
- * enum sgx_attributes - the attributes field in &struct sgx_secs
+ * enum sgx_attribute - the attributes field in &struct sgx_secs
  * @SGX_ATTR_INIT:		Enclave can be entered (is initialized).
  * @SGX_ATTR_DEBUG:		Allow ENCLS(EDBGRD) and ENCLS(EDBGWR).
  * @SGX_ATTR_MODE64BIT:		Tell that this a 64-bit enclave.

