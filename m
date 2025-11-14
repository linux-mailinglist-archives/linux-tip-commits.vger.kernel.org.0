Return-Path: <linux-tip-commits+bounces-7364-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 513DBC5F982
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Nov 2025 00:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5833E4E2FE2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 23:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7100630F543;
	Fri, 14 Nov 2025 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ld4l4ZmR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9OdTTLWn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2D30F53F;
	Fri, 14 Nov 2025 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763163200; cv=none; b=gw6mCE21nqSy+LjCnH3lfpGGrYhcVq8VlSo/Eo5+TleOLGXSfZOBVIpqtl7VBacsAQvxZBleCQthJmhwGuju0LNPouMdPv9dRr4Ot0eOHSJ7irp32IaRkEVmDRm4h2NWlZTAvzuHkIUDkd0oSp1RfBD571p2v0dzYLCd2PY4e+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763163200; c=relaxed/simple;
	bh=HGdg3x++CtliiWvzJ9Lt5kgiwCaHLZ7VAAiD151gz9A=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=pvFyqCc1bsB32maflCwpJusWk4RCGDMu8SxP8rJek4ffk+GuyX7l2DBQCMfbY4D+IH1UZJASKAY9S0hbDgFwvyFXXdCFCws/zDOTvpSzZTybYjks5BfGzD1xhnPmpL8vzVHZJOATp4QxT9/qoa1weQZnQ76Mx24Icq/KheExzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ld4l4ZmR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9OdTTLWn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 23:33:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763163196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5INJz/nuxNZKNB7t6MrrIQohGcSgv8TV/V6xrqw+CRM=;
	b=Ld4l4ZmRfz/TkAWqLj/TCy+X5rUgXI7Ealtc52LEe2XShYFGS/QZ1lZbeNx8C7czPZNsfa
	Fsiyln1lRp7Z/yt2BqvKLWkYIEfJNd+nvMwal5ZlA8eYeDWCCze6OvOw4AEHbpEpGE6vtL
	2VJXGR8HeNVsWVdfjSQiJGjUcWI3u1LVbuLee4Lkuboi6pEhLVAtKHa95h+GNrlsdKfTjf
	vwS7gj0MYJfmbs3X8uMFq+3LvxEcEayRAUjgnNbmk8+8D2KdVDcal5+wkKsAxz9MCE0Bin
	/t+qUXj7VSvh9QR/xwnrNzfmPfcIYBwyDU1+vcVrYfGmEVCPUvI650M5xI0wCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763163196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5INJz/nuxNZKNB7t6MrrIQohGcSgv8TV/V6xrqw+CRM=;
	b=9OdTTLWniKoz6Ij6b80nrpPsOco3ZK3zkbeLjkDqrHGdmCosvqwF8SwVfXkyYYrYJKWPnO
	XpiKuNj+A64jbsBQ==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Remove superfluous asterisk from copyright
 comment in asm/sgx.h
Cc: Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176316319575.498.13125600676665351274.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     55bf13b612579a2b4ed81f3891c36d1cde7579a3
Gitweb:        https://git.kernel.org/tip/55bf13b612579a2b4ed81f3891c36d1cde7=
579a3
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Wed, 12 Nov 2025 08:07:07 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 14 Nov 2025 15:30:28 -08:00

x86/sgx: Remove superfluous asterisk from copyright comment in asm/sgx.h

Drop an asterisk from a file-level copyright comment so that the comment
isn't intrepeted as a kernel-doc comment.

E.g. if arch/x86/include/asm/sgx.h is fed into kernel-doc processing:

  WARNING: ./arch/x86/include/asm/sgx.h:2 This comment starts with '/**',
  but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://patch.msgid.link/20251112160708.1343355-5-seanjc%40google.com
---
 arch/x86/include/asm/sgx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index a88c4ab..3c90cae 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * Copyright(c) 2016-20 Intel Corporation.
  *
  * Intel Software Guard Extensions (SGX) support.

