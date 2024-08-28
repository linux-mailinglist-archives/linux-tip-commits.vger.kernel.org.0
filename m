Return-Path: <linux-tip-commits+bounces-2134-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E37962ED5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Aug 2024 19:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247321C21E02
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Aug 2024 17:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F45B1514EE;
	Wed, 28 Aug 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mDxlN9m+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+qShaJL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6052A1A4F35;
	Wed, 28 Aug 2024 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867156; cv=none; b=WN+rN4xBl4yAZAZOaeeN4WIAM/mdIv/pt+cjyHyw+je+WMo/i4+TW3OBehvkK9CXlO5gzhbjHkkrP1VbYG6GfU/E+L62O/rccg1jtZROqDZc7KNqzeEzk4dXrZA6YUfMlg2SaW0uHp2G+uvDOQ+KTb3Gpapo3/vefU4LOdeH+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867156; c=relaxed/simple;
	bh=lOurk7AhTlthtXku7atQB0Ptd2lozI4rZx20PrvEoaU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PuoZou9F/wb83u+l7/oplnJwFEkdxNa2r7pYtdSxmYtLY753PL4Y3lnq2wmynvzeB7i4QTstHkvVw903QGwgzxJAQQo72iId41YD0l2DRbIyN+LN8y4eE7eSHdjTqVWdpsTnbfxRhMn2ecpbKNcDhFkcWHh1PYLABNI5xjC5gjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mDxlN9m+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+qShaJL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Aug 2024 17:45:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724867152;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJsyvcBysIxef7bOBH/ti8h2ZRNf4rEV1OyumqNYgcs=;
	b=mDxlN9m+pO9ZG7j7/XekqEuFAfVl4z9J/psGmDmMJ9qN9dK9INoJPWe86yeY926bcN/nYs
	yu1XeCKMacczKm5ghkemXmZTQLiW54kPYJsU+GtfdDOnb7SkVdSKZIR8oe/QcMpzIyQvuN
	TL6kEPkDa/YwormMV6fdMQmFTqsBh2DG1fAHKX9u4Gh79ojeO+ZxSr01a1cNkApCPi0L3N
	3IhDcpH0xMiTzdjILLiH52hGlGmp0x35e1bAVi36LKn0nNZ773e0WI1k/PROhPXtFj4PDB
	b0I7ZExul2uOPhZRq59S5nTPuWRMGsG+fmw0i0WLB2HwciXF2bW/c/Bwz4LXDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724867152;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJsyvcBysIxef7bOBH/ti8h2ZRNf4rEV1OyumqNYgcs=;
	b=i+qShaJL4xw8cCyxxakXxKfOvLFwzYrwAhuy4LLSX3/ER6kybu+HTIXwJYHK4QgKTHuWh2
	O13P/0c+3nZPCMCA==
From: "tip-bot2 for Muhammad Usama Anjum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] MAINTAINERS: Add selftests/x86 entry
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240610052810.1488793-1-usama.anjum@collabora.com>
References: <20240610052810.1488793-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172486715194.2215.8525924173701820802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     4460e8538ef17c86eae46ccbe096eee8c740a7d0
Gitweb:        https://git.kernel.org/tip/4460e8538ef17c86eae46ccbe096eee8c740a7d0
Author:        Muhammad Usama Anjum <usama.anjum@collabora.com>
AuthorDate:    Mon, 10 Jun 2024 10:28:10 +05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 28 Aug 2024 19:32:47 +02:00

MAINTAINERS: Add selftests/x86 entry

There are no maintainers specified for tools/testing/selftests/x86.  Shuah has
mentioned [1] that the patches should go through x86 tree or in special cases
directly to Shuah's tree after getting ack-ed from x86 maintainers. Different
people have been confused when sending patches as correct maintainers aren't
found by get_maintainer.pl script. Fix this by adding entry to MAINTAINERS
file.

  [1] https://lore.kernel.org/all/90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20240610052810.1488793-1-usama.anjum@collabora.com
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6daab3f..7715a80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24772,6 +24772,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 F:	Documentation/arch/x86/
 F:	Documentation/devicetree/bindings/x86/
 F:	arch/x86/
+F:	tools/testing/selftests/x86
 
 X86 CPUID DATABASE
 M:	Borislav Petkov <bp@alien8.de>

