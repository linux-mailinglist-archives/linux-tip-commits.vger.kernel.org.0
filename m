Return-Path: <linux-tip-commits+bounces-6869-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 580F2BE2885
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69701A62634
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EB131E10D;
	Thu, 16 Oct 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hrWxepfy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ekOBS8/s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017931A815;
	Thu, 16 Oct 2025 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608353; cv=none; b=Dcq0/oYzUDXfaD5hkRohpP+zxjnnWL0UzIp1hfkHGJh5VuP0hvDGqKQGi7O9V1SKGr4Zb4aHdpqbzT/sNd7GogwaVlUwYiY/TYAh/djpu3v6xiGOcCHnxPyWSw+eiGxOH4s1Vnm/rPsOKTGAoIDKVA5UznasNluAtPw0QqB0vkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608353; c=relaxed/simple;
	bh=z33Qsrdk5aP000XbvVCMLJ4KJHzxr34kbU/QWb7emlY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=s/aAOIpWFurjKtgrp1pLPty51EFowLYnCWF134R0rJ9FYUVOonSQJG2PjnCwNSeS51a76LyJgjCW0SMlIWRm+/7BAXPxFL1cd19wz913Ev7GVvuO2tj0W5xIFkOfowppJEtj42loJNLt++HctPSV/n59pD54MCxa9Fjqt5Dz5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hrWxepfy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ekOBS8/s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Mkh1Cefgb6ZBW9ilzyyht0iQlTuLGzjHBsimDcXUgvE=;
	b=hrWxepfyxjvW01RG0jekygwUXvxs5lKH8H33kgQ5FhknZYzsK4xuYehrKqEIWpN0UFnxhC
	na7YOypjgsg4tKrvUrwDw9L36uynLgl8ByA/wLJJOB/xYKj2LPASoZJXlrGtP2B5iaRH2W
	jmCrwm8XeeP5bbWClOzi3BgLdGvvx1b1OFbxekmtKInSIpWFgd0+XevufQ+/4GQpXsX7lv
	O3T+GiKEMtRTAY+WR9XKrCnY4PVGx2apDqQAyEWQ3SOmBcJpkN52RX5PMUuHPwed0i8KOJ
	hpaTBz9cF32s7lsmkIy7a5RUxn+0hIgY4cIcM8HK07e1H4cGvFF1sTUi2+E5Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Mkh1Cefgb6ZBW9ilzyyht0iQlTuLGzjHBsimDcXUgvE=;
	b=ekOBS8/soYFxrVguN84xL1CNnaupkIxUGnmQ0w06m0lPP+fhhu6un+y2qxMdvFmpTmVWfh
	AyWLMuO65ZFRM3CA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] livepatch/klp-build: Introduce fix-patch-lines
 script to avoid __LINE__ diff noise
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060832737.709179.16711247771181435271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     abaf1f42ddd070662fb419aed29c985ea209bd88
Gitweb:        https://git.kernel.org/tip/abaf1f42ddd070662fb419aed29c985ea20=
9bd88
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:04:06 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:19 -07:00

livepatch/klp-build: Introduce fix-patch-lines script to avoid __LINE__ diff =
noise

The __LINE__ macro creates challenges for binary diffing.  When a .patch
file adds or removes lines, it shifts the line numbers for all code
below it.

This can cause the code generation of functions using __LINE__ to change
due to the line number constant being embedded in a MOV instruction,
despite there being no semantic difference.

Avoid such false positives by adding a fix-patch-lines script which can
be used to insert a #line directive in each patch hunk affecting the
line numbering.  This script will be used by klp-build, which will be
introduced in a subsequent patch.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 MAINTAINERS                       |  1 +-
 scripts/livepatch/fix-patch-lines | 79 ++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+)
 create mode 100755 scripts/livepatch/fix-patch-lines

diff --git a/MAINTAINERS b/MAINTAINERS
index 755e252..fc573e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14443,6 +14443,7 @@ F:	include/linux/livepatch*.h
 F:	kernel/livepatch/
 F:	kernel/module/livepatch.c
 F:	samples/livepatch/
+F:	scripts/livepatch/
 F:	tools/testing/selftests/livepatch/
=20
 LLC (802.2)
diff --git a/scripts/livepatch/fix-patch-lines b/scripts/livepatch/fix-patch-=
lines
new file mode 100755
index 0000000..73c5e3d
--- /dev/null
+++ b/scripts/livepatch/fix-patch-lines
@@ -0,0 +1,79 @@
+#!/usr/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
+#
+# Use #line directives to preserve original __LINE__ numbers across patches =
to
+# avoid unwanted compilation changes.
+
+BEGIN {
+	in_hunk =3D 0
+	skip    =3D 0
+}
+
+/^--- / {
+	skip =3D $2 !~ /\.(c|h)$/
+	print
+	next
+}
+
+/^@@/ {
+	if (skip) {
+		print
+		next
+	}
+
+	in_hunk =3D 1
+
+	# for @@ -1,3 +1,4 @@:
+	#   1: line number in old file
+	#   3: how many lines the hunk covers in old file
+	#   1: line number in new file
+	#   4: how many lines the hunk covers in new file
+
+	match($0, /^@@ -([0-9]+)(,([0-9]+))? \+([0-9]+)(,([0-9]+))? @@/, m)
+
+	# Set 'cur' to the old file's line number at the start of the hunk.  It
+	# gets incremented for every context line and every line removal, so
+	# that it always represents the old file's current line number.
+	cur =3D m[1]
+
+	# last =3D last line number of current hunk
+	last =3D cur + (m[3] ? m[3] : 1) - 1
+
+	need_line_directive =3D 0
+
+	print
+	next
+}
+
+{
+	if (skip || !in_hunk || $0 ~ /^\\ No newline at end of file/) {
+		print
+		next
+	}
+
+	# change line
+	if ($0 ~ /^[+-]/) {
+		# inject #line after this group of changes
+		need_line_directive =3D 1
+
+		if ($0 ~ /^-/)
+			cur++
+
+		print
+		next
+	}
+
+	# If this is the first context line after a group of changes, inject
+	# the #line directive to force the compiler to correct the line
+	# numbering to match the original file.
+	if (need_line_directive) {
+		print "+#line " cur
+		need_line_directive =3D 0
+	}
+
+	if (cur =3D=3D last)
+		in_hunk =3D 0
+
+	cur++
+	print
+}

