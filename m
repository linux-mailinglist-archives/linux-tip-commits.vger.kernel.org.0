Return-Path: <linux-tip-commits+bounces-5201-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4B9AA7A08
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 21:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170DC3B2F7E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4671EFFBB;
	Fri,  2 May 2025 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kvtf0oRn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/QtCpPtC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3339F1EF372;
	Fri,  2 May 2025 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212975; cv=none; b=dtcvpKp0XuQNU8iHKI6cZFHj/oCc2hgRXQsOCpauRbxPC6AwsA+zdevK/cRED92fQs7sjlR3PA3Pyjcv5WmSlaSWFubLaYCg2e9U9jpiAh7jbWOfP7NZ40wbLZ+OjGq5hZ83oNdW3mo+l2la0beuLsoLWZM2aXjA0bA2KV4P6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212975; c=relaxed/simple;
	bh=zg/IEQz7gJw8zrPiVfIWKxHIf9cXnsyiKM4G8wd4zZs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NcfJ6TCi+bu8VKsktDxamtI3fAy9bjlzfXZ1YqpWMkQzWADanlPXIazX+2vfOPJDOf1FmETnWUH/Y/Mcky2J81Cnu0nxN0QEmSWJknvttX8aDR2LaX4mAdFg2p2+3tLpEgTdF2RqKh0EVENZZo18iIHZMrhrOstmyBtfVkyw1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kvtf0oRn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/QtCpPtC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 19:09:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746212972;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEt9mvmL31MTjKxEzdKHB5liGKKvSnwmpLSICWzpJWo=;
	b=Kvtf0oRnTIsfiEZHMAZHY789oRNnimz67Th8Yq0ZsYzaEsB7EQcjynK9MTY1mf/vnrizx+
	DH2fUJ8jPy/ifvJlmYGFbwWss1luVDKJzhs8UYnND+rX5bWZfiWeRZA9OiukMZXMgsb/09
	l5hCTw1i3EBJgVdEy2CFz0wmUfcrvKn3cYYUEifvzi0Uu5bWpUSaqKH5Q7zZZV26xJVrhT
	+AObP8xOsFd0Y2ty3Lelt+2BZtaTOkZ3FYa7SbMWfAqoUZfF+swoso7757a9Ni+aQgD1Vk
	zzGRY8upv3gNS2riFjgwwBiyhZNr3Xd7Db4kUd9xTrkqBuaI9rjdTCYz0WRR/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746212972;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEt9mvmL31MTjKxEzdKHB5liGKKvSnwmpLSICWzpJWo=;
	b=/QtCpPtCJpU03mzMX2Tw9kfIqL+TXosHs79+hFAoTYtZ0jgZes7Yjpkr4ibMNMkh8RvmFv
	L+EjSyCaM+IramCw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] vdso: Reject absolute relocations during build
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250430-vdso-absolute-reloc-v2-2-5efcc3bc4b26@linutronix.de>
References: <20250430-vdso-absolute-reloc-v2-2-5efcc3bc4b26@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174621296673.22196.7605277890848696857.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     7aeb1538be5df3efa1d799e5428ac3a0ae802293
Gitweb:        https://git.kernel.org/tip/7aeb1538be5df3efa1d799e5428ac3a0ae8=
02293
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 30 Apr 2025 11:20:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 May 2025 20:57:11 +02:00

vdso: Reject absolute relocations during build

All vDSO code needs to be completely position independent.
Symbol references are marked as hidden so the compiler emits
PC-relative relocations. However there are cases where the compiler may
still emit absolute relocations, as they are valid in regular PIC DSO code.
These would be resolved by the linker and will break at runtime.

Introduce a build-time check for absolute relocations.
The check is done on the object files as the relocations will not exist
anymore in the final DSO. As there is no extension point for the
compilation of each object file, perform the validation in vdso_check.

Debug information can contain legal absolute relocations and readelf can
not print relocations from the .text section only. Make use of the fact
that all global vDSO symbols follow the naming pattern "vdso_u_".

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250430-vdso-absolute-reloc-v2-2-5efcc3bc4=
b26@linutronix.de
Link: https://lore.kernel.org/lkml/aApGPAoctq_eoE2g@t14ultra/
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D120002
---
 lib/vdso/Makefile.include | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/vdso/Makefile.include b/lib/vdso/Makefile.include
index cedbf15..04257d0 100644
--- a/lib/vdso/Makefile.include
+++ b/lib/vdso/Makefile.include
@@ -12,7 +12,13 @@ c-getrandom-$(CONFIG_VDSO_GETRANDOM) :=3D $(addprefix $(GE=
NERIC_VDSO_DIR), getrand
 #
 # As a workaround for some GNU ld ports which produce unneeded R_*_NONE
 # dynamic relocations, ignore R_*_NONE.
+#
+# Also validate that no absolute relocations against global symbols are pres=
ent
+# in the object files.
 quiet_cmd_vdso_check =3D VDSOCHK $@
       cmd_vdso_check =3D if $(READELF) -rW $@ | grep -v _NONE | grep -q " R_=
\w*_"; \
 		       then (echo >&2 "$@: dynamic relocations are not supported"; \
+			     rm -f $@; /bin/false); fi && \
+		       if $(READELF) -rW $(filter %.o, $(real-prereqs)) | grep -q " R_\w*_=
ABS.*vdso_u_"; \
+		       then (echo >&2 "$@: absolute relocations are not supported"; \
 			     rm -f $@; /bin/false); fi

