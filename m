Return-Path: <linux-tip-commits+bounces-4556-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0851FA71172
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 08:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B1A1731F1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F7C198E6F;
	Wed, 26 Mar 2025 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HfH92niy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DJ5+gQy8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30719189BAC;
	Wed, 26 Mar 2025 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974320; cv=none; b=b8apPPpxmuStdZE6De+9HNARqT11M1+yRIfn2Nh/qU7WKpfjDRPfVoJGMY/SBdTsQc/G5SKKqsjgTRfY67jnwDZ4k511jCidTwMVz3mVdoGQ7ZCsiFp88nMZYj1aZN+XAjivH2HCS01whMPiG/k736szw5nolYFe+4GeV9tHjBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974320; c=relaxed/simple;
	bh=ZUyp9CN4hWSvNhvE43tBDf8XGU/txuDZnZD1KBf+XEA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lytwaPZWO+jhKUfKv8zrtmYIefEkxb9Se41iqtBq85ePb9U4s63JzCIoBihEILU1yOdUF3SRLD3LMFbR00WkdIOEUQ4dboMGqNBOghbx5g6RbKKkjXIqOqlrKETZoScb5+6RgIUFhSuih/MNjPY5OVHzTBMxAcDm/gC+Sfy9VmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HfH92niy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DJ5+gQy8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Mar 2025 07:31:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742974316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/CgGRWQzD7W0+UFUzB+3N7/CvTBPElGdAC0ocRIqg4=;
	b=HfH92niyx06xkIEx1DWHV9nh0Q6jULIB18mFVnfT5rIbDn1lH8MFYQ9vEzPVwufAo87DPw
	maslH53vm+Uk42DMqE04ireMq4bm45AsnPTb5qs1/c0AMUvZmSQzbIukakZ5e69hilwUPA
	y4Q4tEwzFkRFiUg9lTdqAZpK6zj+PeGaT+WbFtq2zudJJZR4nAXdpXLxGAFUu5L1JaJnHP
	Tht1Y9elK0njoxOHOCfjWWeSqGPHmDT1052UqdNoSwQ7DTq5JppJzB9E3FC4U040cf+8Es
	Nc2U1bPWN3oQxAdui1VTbDzhVVzcn4mUH52L03xW0giUz/+SPiOQAIFUF8/KLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742974316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/CgGRWQzD7W0+UFUzB+3N7/CvTBPElGdAC0ocRIqg4=;
	b=DJ5+gQy8X5G2fv6B669yacrEH8L9sefj/IotrJuaTga9czeG4Op16YcZ+bU+CO6Vq4n/hV
	/ARSwHRQ/dphRbBA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix NULL printf() '%s' argument in
 builtin-check.c:save_argv()
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <a814ed8b08fb410be29498a20a5fbbb26e907ecf.1742952512.git.jpoimboe@kernel.org>
References:
 <a814ed8b08fb410be29498a20a5fbbb26e907ecf.1742952512.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174297431194.14745.4198914327730875327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     89721c2ca8aec6f45166acf61ae32f64f2f1d2db
Gitweb:        https://git.kernel.org/tip/89721c2ca8aec6f45166acf61ae32f64f2f1d2db
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 25 Mar 2025 18:30:37 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Mar 2025 08:24:59 +01:00

objtool: Fix NULL printf() '%s' argument in builtin-check.c:save_argv()

It's probably not the best idea to pass a string pointer to printf()
right after confirming said pointer is NULL.  Fix the typo and use
argv[i] instead.

Fixes: c5995abe1547 ("objtool: Improve error handling")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/r/a814ed8b08fb410be29498a20a5fbbb26e907ecf.1742952512.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/20250326103854.309e3c60@canb.auug.org.au
---
 tools/objtool/builtin-check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 2bdff91..e364ab6 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -238,7 +238,7 @@ static void save_argv(int argc, const char **argv)
 	for (int i = 0; i < argc; i++) {
 		orig_argv[i] = strdup(argv[i]);
 		if (!orig_argv[i]) {
-			WARN_GLIBC("strdup(%s)", orig_argv[i]);
+			WARN_GLIBC("strdup(%s)", argv[i]);
 			exit(1);
 		}
 	};

