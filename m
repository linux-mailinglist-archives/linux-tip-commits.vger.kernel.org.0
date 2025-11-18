Return-Path: <linux-tip-commits+bounces-7383-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A1C6873E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 10:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4AAE92A5AD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 09:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB693019BB;
	Tue, 18 Nov 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fKF69d3s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4WNSBLgX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7968308F0F;
	Tue, 18 Nov 2025 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457254; cv=none; b=iwHTkt30N2vtrZiG8JmqPHA5muUjORF7qgS+g8rXEXWOxGiGuOXDfsrmhJitfjkl1arK8mdZDfIAmQInyrqQE0z0T7lICclsoFIqNnB1ocdvgRXG1BBLa9KOVl82qImv4cStMaARo/vBNuCdNGhjo/uLyKYhfVqr0OMq02uoY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457254; c=relaxed/simple;
	bh=KyZez/8ZJAc6nVm8OlUNcWJ7OZ1kiAgeyMA6S1ql2g8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=APb79Bl+mWxH809FuUNWJAg6Ax88oZlD0QVsDvAJeG8cBb9xevHP5/90qxM/z/RhKY0PACtn9G5RlL61jO6yASrrsB0a1YoVy5wNxsNlaOqZdObRd11Nq+DWNVOjFdsSlEZGPsbtP4ROmGG3sw1n2CvI2MC2STjMfUp2+zB9kxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fKF69d3s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4WNSBLgX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 09:14:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763457249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYOX1wnjrFgDRI9HgTOjUygj1C7HLtn5Wx7uOvEALCI=;
	b=fKF69d3sjkY2ygEB8P+t3inalDwPIqBN7DDJrSMS6aQZK35NbqzoIQGaQBjJfhi7tey59j
	g5Xnx0zviWqXGboi4BiVqtM3VRggpNxbxdpV30euEb4h/Sj9hh9p36AujWFpFYyyvF6opX
	7mo7ubUl3AITlY3+xvBR6pLrO7lENAWnMGwfHpLyM6qDEDLoBEOxztVn/yk6aipWEl9m1U
	rYoe76U/VDn0cEndUT0Te5IEeACmUahwo7GM/yzM1jV6X8JhBfWkC5qQ92bVYg5YwJGwyi
	L7U9uDq/pIhfK+PPVWDtwPvGU7djVXkoQ4OiAoYoyu7r/nN72eMpt3FsloRnkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763457249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYOX1wnjrFgDRI9HgTOjUygj1C7HLtn5Wx7uOvEALCI=;
	b=4WNSBLgXUjvAxJr1js/wSDtveOee/2Bln6bOCEI/OP1W5+T9W8pD3pqFtpsZcczyDATcHk
	j0ggDiv7nUrhfUDA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/klp: Only enable --checksum when needed
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <edbb1ca215e4926e02edb493b68b9d6d063e902f.1762990139.git.jpoimboe@kernel.org>
References:
 <edbb1ca215e4926e02edb493b68b9d6d063e902f.1762990139.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176345724486.498.8088274037182866475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2092007aa32f8dd968c38751bd1b7cac9b1f738d
Gitweb:        https://git.kernel.org/tip/2092007aa32f8dd968c38751bd1b7cac9b1=
f738d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Nov 2025 15:32:34 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Nov 2025 09:59:26 +01:00

objtool/klp: Only enable --checksum when needed

With CONFIG_KLP_BUILD enabled, checksums are only needed during a
klp-build run.  There's no need to enable them for normal kernel builds.

This also has the benefit of softening the xxhash dependency.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://patch.msgid.link/edbb1ca215e4926e02edb493b68b9d6d063e902f.17629=
90139.git.jpoimboe@kernel.org
---
 arch/x86/boot/startup/Makefile | 2 +-
 scripts/Makefile.lib           | 1 -
 scripts/livepatch/klp-build    | 4 ++++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index e8fdf02..5e499cf 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -36,7 +36,7 @@ $(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STAND=
ARD :=3D y
 # relocations, even if other objtool actions are being deferred.
 #
 $(pi-objs): objtool-enabled	=3D 1
-$(pi-objs): objtool-args	=3D $(if $(delay-objtool),,$(objtool-args-y)) --noa=
bs
+$(pi-objs): objtool-args	=3D $(if $(delay-objtool),--dry-run,$(objtool-args-=
y)) --noabs
=20
 #
 # Confine the startup code by prefixing all symbols with __pi_ (for position
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f4b3391..28a1c08 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -173,7 +173,6 @@ ifdef CONFIG_OBJTOOL
=20
 objtool :=3D $(objtree)/tools/objtool/objtool
=20
-objtool-args-$(CONFIG_KLP_BUILD)			+=3D --checksum
 objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+=3D --hacks=3Djump_label
 objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+=3D --hacks=3Dnoinstr
 objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+=3D --hacks=3Dskylake
diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 881e052..8822721 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -489,8 +489,11 @@ clean_kernel() {
=20
 build_kernel() {
 	local log=3D"$TMP_DIR/build.log"
+	local objtool_args=3D()
 	local cmd=3D()
=20
+	objtool_args=3D("--checksum")
+
 	cmd=3D("make")
=20
 	# When a patch to a kernel module references a newly created unexported
@@ -513,6 +516,7 @@ build_kernel() {
 	cmd+=3D("$VERBOSE")
 	cmd+=3D("-j$JOBS")
 	cmd+=3D("KCFLAGS=3D-ffunction-sections -fdata-sections")
+	cmd+=3D("OBJTOOL_ARGS=3D${objtool_args[*]}")
 	cmd+=3D("vmlinux")
 	cmd+=3D("modules")
=20

