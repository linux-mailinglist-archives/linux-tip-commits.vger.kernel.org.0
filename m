Return-Path: <linux-tip-commits+bounces-6052-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FE0AFEC80
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 16:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2A21889365
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C527F2E54DE;
	Wed,  9 Jul 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wiEsVonQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W911VrLj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C02E3371;
	Wed,  9 Jul 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072492; cv=none; b=Em+eZqgC7gW9uUPFMPdfJXBtNDOaOkTWpKZDQnLYY2f2Pytws9fjvYX3IMxydjh6SsmPrd4OpPS73MwNfXzkEgOvtR3ps9pl3HQjJ4HEEJ1v1vEdrF3PgFHtrA49vELrQWMP8SrA85TGaTA0/d9agsuua/sI2qRMOiF2WYkc4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072492; c=relaxed/simple;
	bh=g6uHduEa1jJdAvOU3aM+YepqUPEiouFTjomF5rLaqBU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Sy4w5rFAdPkAlOlGUnmaBR6y0uECOMyV759RVhGCdn0sxS3dYxoeWng6ZVo8KZ72AlD+aY1lqvlFxXg+BPT+rsOKw0OObUXfI6BWk91h76lFZr5/AIj+Csx+kPgKc2aFMIBZkfn72vxiA8QkbaSxuqdobhpBwR6ZlleKlUOAt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wiEsVonQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W911VrLj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 14:48:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752072489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Q0LlHTs5pPImpBen/C7yLL4RqFEWXqIL3DBSye2MISc=;
	b=wiEsVonQM7Mu7lT4alP9CrVcgIWNnDmCpYElaGYzIGHuf5gg5zWh+mCDhr5+zANlbUPMz3
	TNAl9yBNBYv1bpEmCHDAfxeGPLUlKJ3q8fG8Vuwmz9IUxC0hsT+4gbnZ2+jI49YiV8r2bh
	JRGA4Zq923oTVgP20SJ6AV62/TRXjhx848PCRIKWV+MsdjFcEpI+ir1xPTl2kia5URRKEA
	nVQIp3NPIBUzYuVitpxEFdUhu5IRry8L9HMFq3phD6xWIKOD3l8j8TerURLc1NwYMFD3wR
	2JgW7Y4rPQZnitDWupO5erfopGx2TqBLihXcEQD1Hfhp4uOnjKMFRFhwMfx0LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752072489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Q0LlHTs5pPImpBen/C7yLL4RqFEWXqIL3DBSye2MISc=;
	b=W911VrLjtrnHDPDBP2riOe/rOfaX4h5bpNyOSRHFPW6Y9zJBGmAxLLmJYQ8ngxjrSVXLcA
	aE/0tdPTyWUauHBQ==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] MAINTAINERS: Update Kirill Shutemov's email address
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175207248822.406.4378856759816500977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     f7db1836ce9a2db82eae1bc059815c32fc68f8c5
Gitweb:        https://git.kernel.org/tip/f7db1836ce9a2db82eae1bc059815c32fc68f8c5
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 08 Jul 2025 13:19:22 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Jul 2025 07:39:53 -07:00

MAINTAINERS: Update Kirill Shutemov's email address

Update MAINTAINERS to use my @kernel.org email address.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250708101922.50560-4-kirill.shutemov%40linux.intel.com
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index b0ace71..85ad46d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -416,6 +416,7 @@ Kenneth W Chen <kenneth.w.chen@intel.com>
 Kenneth Westfield <quic_kwestfie@quicinc.com> <kwestfie@codeaurora.org>
 Kiran Gunda <quic_kgunda@quicinc.com> <kgunda@codeaurora.org>
 Kirill Tkhai <tkhai@ya.ru> <ktkhai@virtuozzo.com>
+Kirill A. Shutemov <kas@kernel.org> <kirill.shutemov@linux.intel.com>
 Kishon Vijay Abraham I <kishon@kernel.org> <kishon@ti.com>
 Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@linaro.org>
 Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@somainline.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 48f0662..5893a46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26944,7 +26944,7 @@ F:	arch/x86/kernel/stacktrace.c
 F:	arch/x86/kernel/unwind_*.c
 
 X86 TRUST DOMAIN EXTENSIONS (TDX)
-M:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
+M:	Kirill A. Shutemov <kas@kernel.org>
 R:	Dave Hansen <dave.hansen@linux.intel.com>
 R:	Rick Edgecombe <rick.p.edgecombe@intel.com>
 L:	x86@kernel.org

