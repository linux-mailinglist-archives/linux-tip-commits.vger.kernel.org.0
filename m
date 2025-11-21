Return-Path: <linux-tip-commits+bounces-7442-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13396C7850D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 11:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC1204E9765
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64BB34252C;
	Fri, 21 Nov 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TWYqomY4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HCPdxcj1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C034403D;
	Fri, 21 Nov 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719065; cv=none; b=fAqXpHEEjZlxfLuq0JLVPSSLRIVEE0VDlgwXqr5i86dzCYNeNpqoRVrhUUJ7gioBWpnUods5KvjkQh1eG935lAebtxChE93zHFfNn2JvdMQISBkVZWoSitrjTuZgKWVUh6PuVpnI8fV/jPHc3o/p3vY4rpqhGoy+syH42RHrNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719065; c=relaxed/simple;
	bh=+f2ONOqtQ6Toq2i3yfLzjdzEWOdk2sCP1UX/WmbA5GM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KFaZvjTVYOORlKMssrTf+A3n/2KBAdLZHMwudppZkyn0GnVfRoHqFWNmsbIp4EzsISZkMWrGUxUzFniK4t0OWJcKmPOo9l/sZpNYbP+Uzsyq/L7A7UsY7JipqO0ymPehgCUDN7s5mu5fT/Y9HN8uFdmOELkkAmk4RN24pBcKJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TWYqomY4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HCPdxcj1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:57:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763719061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iv8bCjzpoMlkV4WxN7HpFkCCAzW7V1im+pbAkIkM4us=;
	b=TWYqomY404+stt3Td7TJFJEwnS+JUQRBxsPecIvLnvXoiNfSBsEqiIU4+9RYcETs6MBYYU
	XOhZhWGWql7yy69nco+YsLvew4RvLdMFFp0g8MQImxp0g+0O7Cb4LzbvnYu0RvQiR4hSiD
	rJkOoLq4D6tpd6iWdRs++z30ycjxXGH9KpwV0PWOLvEkmx8Fr9aMqFSPjhukMHgxCMANEM
	oU30AlDN3b2ef9DPfTOstZlxcWzva3Ko1dKXYU0VSJNboxcfw8KcyS1/yf5h0GpawQ0i3m
	IsPsKwd2EtHcBHRqu5WVAfdt+9Bl1Oo1IsTrib3PF7pj4FuOn05tKnvnArws8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763719061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iv8bCjzpoMlkV4WxN7HpFkCCAzW7V1im+pbAkIkM4us=;
	b=HCPdxcj1+PUmDbYizlgXJWEknP1UMlMEWOkyqRkny3qcZxqHrkxv1/58F2Gpzj//pbFLxX
	gxLJZHO/oBHi6DBA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] kbuild: Check for functions with ambiguous
 -ffunction-sections section names
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <a6a49644a34964f7e02f3a8ce43af03e72817180.1763669451.git.jpoimboe@kernel.org>
References:
 <a6a49644a34964f7e02f3a8ce43af03e72817180.1763669451.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176371906023.498.8183340055396440095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     93863f3f859a626347ce2ec18947b11357b4ca14
Gitweb:        https://git.kernel.org/tip/93863f3f859a626347ce2ec18947b11357b=
4ca14
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 20 Nov 2025 12:14:20 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 10:04:10 +01:00

kbuild: Check for functions with ambiguous -ffunction-sections section names

Commit 9c7dc1dd897a ("objtool: Warn on functions with ambiguous
-ffunction-sections section names") only works for drivers which are
compiled on architectures supported by objtool.

Make a script to perform the same check for all architectures.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/a6a49644a34964f7e02f3a8ce43af03e72817180.17636=
69451.git.jpoimboe@kernel.org
---
 include/asm-generic/vmlinux.lds.h |  2 +-
 scripts/Makefile.vmlinux_o        |  4 ++++
 scripts/check-function-names.sh   | 25 +++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100755 scripts/check-function-names.sh

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.=
lds.h
index 5efe1de..0cdae6f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -110,7 +110,7 @@
  * .text.startup could be __attribute__((constructor)) code in a *non*
  * ffunction-sections object, which should be placed in .init.text; or it co=
uld
  * be an actual function named startup() in an ffunction-sections object, wh=
ich
- * should be placed in .text.  Objtool will detect and complain about any su=
ch
+ * should be placed in .text.  The build will detect and complain about any =
such
  * ambiguously named functions.
  */
 #define TEXT_MAIN							\
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 20533cc..527352c 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -63,11 +63,15 @@ quiet_cmd_ld_vmlinux.o =3D LD      $@
 	--start-group $(KBUILD_VMLINUX_LIBS) --end-group \
 	$(cmd_objtool)
=20
+cmd_check_function_names =3D $(srctree)/scripts/check-function-names.sh $@
+
 define rule_ld_vmlinux.o
 	$(call cmd_and_savecmd,ld_vmlinux.o)
 	$(call cmd,gen_objtooldep)
+	$(call cmd,check_function_names)
 endef
=20
+
 vmlinux.o: $(initcalls-lds) vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
 	$(call if_changed_rule,ld_vmlinux.o)
=20
diff --git a/scripts/check-function-names.sh b/scripts/check-function-names.sh
new file mode 100755
index 0000000..4100425
--- /dev/null
+++ b/scripts/check-function-names.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Certain function names are disallowed due to section name ambiguities
+# introduced by -ffunction-sections.
+#
+# See the comment above TEXT_MAIN in include/asm-generic/vmlinux.lds.h.
+
+objfile=3D"$1"
+
+if [ ! -f "$objfile" ]; then
+	echo "usage: $0 <file.o>" >&2
+	exit 1
+fi
+
+bad_symbols=3D$(nm "$objfile" | awk '$2 ~ /^[TtWw]$/ {print $3}' | grep -E '=
^(startup|exit|split|unlikely|hot|unknown)(\.|$)')
+
+if [ -n "$bad_symbols" ]; then
+	echo "$bad_symbols" | while read -r sym; do
+		echo "$objfile: error: $sym() function name creates ambiguity with -ffunct=
ion-sections" >&2
+	done
+	exit 1
+fi
+
+exit 0

