Return-Path: <linux-tip-commits+bounces-6878-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C25BE28E8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B1C14FE95E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3A32E75C;
	Thu, 16 Oct 2025 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PuEMwUfB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X7Wj/Eas"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851A2E0921;
	Thu, 16 Oct 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608367; cv=none; b=D36Bw6gpRAGxF2SNlkVtHViWJmY4IBB9fwxGUxFDXxPm1QqJYQ8nUzakhQ+3icYBHHZ6CuO5Llh1DcNnVl/1i8Uuhrcs+I0tC8y874mNbsV5L3BqK3LyvJ1sTVIDN6cMY0zNbdTBvm8MmJKbYi1bNm0a1SikEsjh9tBkHimZugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608367; c=relaxed/simple;
	bh=jeVu1qS3KuWzZdu0LMOaYsSaCvIbC//ProHrbK7MQgc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=X8HoelrFFHaSk4DIb5xucLroDHVJZBOtX7sx9ik0mEvCIvQlkyqHFyYg7N6Z+jNCCz4Cq1M6fttLsiL9TOebbVeEYGOsuwgoPwn+PnbpPKsencHwxNY9dZny0iqBcdxLv+NW9pe/oXZNWGPpyPgIx4c2ZnMY+6auUlwwQvCP1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PuEMwUfB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X7Wj/Eas; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BxoCpUEfQOz6eopjyZQnDajOFcmy1rUr9OYmf2dNRqg=;
	b=PuEMwUfBQJi1he/nnvYbEtRcxoeXITnSP2fouiTKnHV/p0lWtoEaf0sylH4mZ4xiJrQCAR
	xrU3J17sTmFvDPPTPDzGvXbF0Ommocrs1HUZnw1eaGAp6Ke/dgUjKH4x5nu2jp+/s+awbE
	RY54IjrMqyftj/ZC9thLnHAzZgoOi0OdgDuXX/aQIDHG6fVb+klPEuTYl2xIMRCGDbY755
	zt7vxKQBfPIVUPrFVLByhLlrpOxvA30rld03aSuK+RUNat1vo2KrBG1s56lsbkGlOBGGco
	dQmEKZDQp7Lubx7qP6vc6wzHox8E2KMxZm+xBtjDCNGGxDqc/WJwfJ1rbrB9Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BxoCpUEfQOz6eopjyZQnDajOFcmy1rUr9OYmf2dNRqg=;
	b=X7Wj/EaszcY3E6OLzsu1K6kHQkg4E+oPrKQb4kOScQsYuJ3BhjqASd6Y1OJsXLGxikDXBV
	kbio0HViYwzXXfCg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Unify STACK_FRAME_NON_STANDARD entry sizes
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060834061.709179.10804798631118756137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f6b740ef5f4724f95363ac0d664e88d221343fa1
Gitweb:        https://git.kernel.org/tip/f6b740ef5f4724f95363ac0d664e88d2213=
43fa1
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:56 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:17 -07:00

objtool: Unify STACK_FRAME_NON_STANDARD entry sizes

The C implementation of STACK_FRAME_NON_STANDARD emits 8-byte entries,
whereas the asm version's entries are only 4 bytes.

Make them consistent by converting the asm version to 8-byte entries.

This is much easier than converting the C version to 4-bytes, which
would require awkwardly putting inline asm in a dummy function in order
to pass the 'func' pointer to the asm.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/objtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 4fea6a0..b18ab53 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -92,7 +92,7 @@
=20
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-	.long \func - .
+	.quad \func
 	.popsection
 .endm
=20

