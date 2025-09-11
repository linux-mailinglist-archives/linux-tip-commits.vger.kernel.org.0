Return-Path: <linux-tip-commits+bounces-6552-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF6B52A2A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 09:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193511898E7F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8480227703D;
	Thu, 11 Sep 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tCBdzlEv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gDBkS0x3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE9275AE4;
	Thu, 11 Sep 2025 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576102; cv=none; b=FK4KfFK4Uz8zFu0+f48g7gAQpqsv0N9RzeyX4BFI/b4AOnF/kueqrRZQ4oiKD2NiKtLLQ9hANeP9sgDAKnM9pnG7ex2Do9Pore+D6Koh9VaCptXhgULIr1zGwx9V/Z5Za6ykIenKMwxKNJuHmlEiFkrVCYZR0G09Tx2kpnb3H1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576102; c=relaxed/simple;
	bh=jjU4nHnj9IMtYuEp6wG6Wwy6AqwCP5xkECHMrgYHRhg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=tJMb0uRsGghN+6OcOOvhtclfX5izTGcDQbQCiQJ9/GdOM7FtROScKANQGoPZJHz8McCtjfmYwqvLgLbfDXgYJ+uHFdd3AjWto0ODbzdCbMix9MSmVMvc5ZKX5S+AOj0DgkKHoE9Qyxqw7f2Vux6tc5i5m/XGY/4SbiOArxrD3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tCBdzlEv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gDBkS0x3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 07:34:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757576099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=SFZQgdbSQetdpkSR55ZM4/R7upcnTwzCYh/AbXaQBcE=;
	b=tCBdzlEvaMoVY0N5EreWFVfoAHj39dWj6WeAp/WPTgo5VgjMmxh394Lr3MD7UhQO8X6NE6
	UfETm7v01NYXtOUxgihL44OYp3kePPPN1hA46NF4vUqbSemudKdQxCCJJLfJNH3ddEZQBq
	seWl5EzD7nzRC7bIKGs9q3Aww8VXuLj2p4EgNcC//2rVUKHGuNpaUHXgHDwW0AW+iK3Fdx
	B0Jy8yUsngnl2zRf0E9JVxI80UU/GUyITrzEpDnYp3MKpAVhNctXhawJeAhLYmIfn6W51B
	ybZmiLfzrn02jp/h2AMQbhWgIcbBO/aG79/9WErfezcionMmK9ogbs9NDuDnJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757576099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=SFZQgdbSQetdpkSR55ZM4/R7upcnTwzCYh/AbXaQBcE=;
	b=gDBkS0x3CC51+mV2ElJ003LI+85da8wlhOF8Z3RC1lMveKjeTGbxRumKDcx/eWI5Rm+st8
	k1so/lyBdvEI3KCw==
From: "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cfi: Document the "cfi=" bootparam options
Cc: Kees Cook <kees@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175757609765.709179.2818869098867903879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     24452d9ef17502965021ce5df30f4e184245a5ac
Gitweb:        https://git.kernel.org/tip/24452d9ef17502965021ce5df30f4e18424=
5a5ac
Author:        Kees Cook <kees@kernel.org>
AuthorDate:    Wed, 03 Sep 2025 20:46:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Sep 2025 21:59:08 +02:00

x86/cfi: Document the "cfi=3D" bootparam options

The kernel-parameters.txt didn't have a section for the cfi=3D options.
Add it.

Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20250904034656.3670313-3-kees@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt | 17 ++++++++++++++++-
 1 file changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 747a55a..8bbffbb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -608,6 +608,23 @@
 	ccw_timeout_log	[S390]
 			See Documentation/arch/s390/common_io.rst for details.
=20
+	cfi=3D		[X86-64] Set Control Flow Integrity checking features
+			when CONFIG_FINEIBT is enabled.
+			Format: feature[,feature...]
+			Default: auto
+
+			auto:	  Use FineIBT if IBT available, otherwise kCFI.
+				  Under FineIBT, enable "paranoid" mode when
+				  FRED is not available.
+			off:	  Turn off CFI checking.
+			kcfi:	  Use kCFI (disable FineIBT).
+			fineibt:  Use FineIBT (even if IBT not available).
+			norand:   Do not re-randomize CFI hashes.
+			paranoid: Add caller hash checking under FineIBT.
+			bhi:	  Enable register poisoning to stop speculation
+				  across FineIBT. (Disabled by default.)
+			warn:	  Do not enforce CFI checking: warn only.
+
 	cgroup_disable=3D	[KNL] Disable a particular controller or optional feature
 			Format: {name of the controller(s) or feature(s) to disable}
 			The effects of cgroup_disable=3Dfoo are:

