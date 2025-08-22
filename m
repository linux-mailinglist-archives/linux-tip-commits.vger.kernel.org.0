Return-Path: <linux-tip-commits+bounces-6312-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD2DB31CD0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 16:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51851CC5D8A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A133126C1;
	Fri, 22 Aug 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fg4WTblP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wv4+6WUZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C130F548;
	Fri, 22 Aug 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874188; cv=none; b=hou/VokddLhNdRCfKfahG8MQ7M/1ebPP3u/3gvxqN9kL/XsEovzwUAQ44iRMlsMBkFNv1Tk1UPXCMpPK7CNsDj3dzX7xsaR8MKvHIHIevaSuHqH3hzaKLc8GVEcYYJXYHvJI2H/1UIgR0s7tO0kkVf4yTRf69plRM7GjtTWyzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874188; c=relaxed/simple;
	bh=YrcA6iONPdxFIljv1Fr7Fh519tRTjnJNFPGSsxxkl2k=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bXbQJ2pT5pbBCbPO7m3fLygDGjAS3ZO+OdkMyBtegzQSiau6YJCeq9cfRBqamwUb0xyCrpJ9WitiFzfLy4NWlqNfcgRH9sVnG7qMeNz/9ZmJ3c+D+e0vWXRoYeL2LjdDe0RFVppe8Tcqae5lrJuV64qR3EhT8MLWA1XHzDZdHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fg4WTblP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wv4+6WUZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 14:49:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755874186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=koCiqCcLNp86BhXvGOow1MsHnLzx2R0PosIrvk6UKpU=;
	b=Fg4WTblP1i4S8sif4iscujlHlZT10VWe1qnD60CaRRiXCLAQDcssD0HbNnJVv+cgV6KsDt
	xmLQTxwQWAexEcmaZuo7kDbGJwa2NqE8aFACCPVVIP40zY8oDOriE3Wdar3c/KC3nU2WSt
	FJi3X3CXP4ZjiD6tikl0jdqvyYmPfh2QjMX9r7AwlWhKij85FqKEjsNZibTvxT6NSRZAwV
	j12X9fRFCBtnX2263awR1ArScbHQ66H1/QP2yJWkKg/F7VY5Gzbv+criFGyE9mjX7cjwPy
	uOnaQliEog6hypPmZlmdXSJW7yE09ghjiNtECbI0o5pkg4f1mEQKx+XR+gs15Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755874186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=koCiqCcLNp86BhXvGOow1MsHnLzx2R0PosIrvk6UKpU=;
	b=Wv4+6WUZ9EVMF9ofxl8mvSixV08+YP6lJWiabVRJ2UxsTjbGtO5Cia/4Ng/2YeFUg/R5Lb
	Vw2UJETlvnhPuHAA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] MAINTAINERS: Add Rick Edgecombe as a TDX reviewer
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175587418482.1420.13380332399546227198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     957e3855407d943577695531931e8aec938733d2
Gitweb:        https://git.kernel.org/tip/957e3855407d943577695531931e8aec938=
733d2
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 08 Jul 2025 13:19:21 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 22 Aug 2025 07:30:23 -07:00

MAINTAINERS: Add Rick Edgecombe as a TDX reviewer

Rick worked extensively to enable TDX in KVM. He will continue to work
on TDX and should be involved in discussions regarding TDX.

Add Rick as a TDX reviewer.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250708101922.50560-3-kirill.shutemov%40li=
nux.intel.com
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31632e7..86fae89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27325,6 +27325,7 @@ F:	arch/x86/kernel/unwind_*.c
 X86 TRUST DOMAIN EXTENSIONS (TDX)
 M:	Kirill A. Shutemov <kas@kernel.org>
 R:	Dave Hansen <dave.hansen@linux.intel.com>
+R:	Rick Edgecombe <rick.p.edgecombe@intel.com>
 L:	x86@kernel.org
 L:	linux-coco@lists.linux.dev
 S:	Supported

