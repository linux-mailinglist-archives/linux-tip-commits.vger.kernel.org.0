Return-Path: <linux-tip-commits+bounces-5452-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2915AAE925
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 20:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F593AD0D3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1166928DF47;
	Wed,  7 May 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RgIKYUYu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rTqUZ3AM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F392288CB0;
	Wed,  7 May 2025 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643250; cv=none; b=B++FwPPe4Iq4PEpK1VC2qMiN+62lAGquLk2oC43J1aAJoj8YrWOH0AZ17agMQqlfshtUmVoYjxk7bF/QEIYdlzE8XsBmmI+mVvEoYSDo2Fe0nkCrYVt+EMbnxtHOBogUrMdb7BxQrIB5a0la5l1hVH5gxRQjMnYZLDM+SNi6fP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643250; c=relaxed/simple;
	bh=E0qjmsWUdUbvc5RjAooSlVu2JYIj2X51o6YLUv8ALt8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C9VUfHYZggy+g3YGXSMC0l9XqHjSXtIpncZxVmgCwJMhcxNzTPmzLR/cmMQqDNnxnyIB8KZ8KI9Acse/hifjBtGI8IlkfVAVJDalkFqIcuAaCIorn0tlVnN1BCmJwqDyuFTITuprPJCHxt28MXqqU5NHvEHkYSVlzUNbQhffo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RgIKYUYu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rTqUZ3AM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 18:40:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746643246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvdjdutKbIZItgd7xV8+18F8sRzhoQdyBXPiWKeJphE=;
	b=RgIKYUYuonWdNkJ+BO1QaGXQ5vJmMN7NWe9uLQTlSrA6Md8k4xyBRjou5jq8qyBDCAAB8W
	oykqz2DpgibuP7y2+/Ox92T83eqCmEuOACAcrKyKu9qMXIEju3cN3plA8jR+Dys8a4Y50C
	vSl2nG9oO14hp9irvy+GTLliMcZX0E/9KB3bJO0YBb1cyx/MVEPhz166zK5+gukzn3Cpvn
	k0NPXHcgEwQ4ZZwstULlC4iZUiJ4HdiVeiPe602wQ6kcolpnj01FLjKvdZMojooNDXaHIv
	GqmNR/cjl2gi2GNIG0GXSgV5MG5bHmf/dY1f5M0Jk0MFjDXMMWnFCPErgRptqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746643246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvdjdutKbIZItgd7xV8+18F8sRzhoQdyBXPiWKeJphE=;
	b=rTqUZ3AMsLWFpjb6XTL9PFjvqXSYrBQFZlPQ58GlRaox2vuGSXGjpt+Bhe0VBZ4sSPkGoK
	IZ3G56rW7pNK80AA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] um: Add UML version of <asm/tsc.h> to define rdtsc()
Cc: kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <202505080003.0t7ewxGp-lkp@intel.com>
References: <202505080003.0t7ewxGp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174664324585.406.10812098910624084030.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     24b58adaa7508d9d2cdb6bca44803954baf24459
Gitweb:        https://git.kernel.org/tip/24b58adaa7508d9d2cdb6bca44803954baf=
24459
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 07 May 2025 20:18:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 07 May 2025 20:30:39 +02:00

um: Add UML version of <asm/tsc.h> to define rdtsc()

In the x86 tree rdtsc() methods got moved out of <asm/msr.h>, but this
broke UML, as the x86 version of <asm/tsc.h> cannot be used by UML as-is:

	  CC [M]  drivers/accel/habanalabs/common/habanalabs_ioctl.o
	In file included from drivers/accel/habanalabs/common/habanalabs_ioctl.c:20:
	./arch/x86/include/asm/tsc.h:70:28: error: conflicting types for =E2=80=98cy=
cles_t=E2=80=99; have =E2=80=98long long unsigned int=E2=80=99
	   70 | typedef unsigned long long cycles_t;
	      |                            ^~~~~~~~
	In file included from ./arch/um/include/asm/timex.h:7,
	                 from ./include/linux/timex.h:67,
	                 from ./include/linux/time32.h:13,
	                 from ./include/linux/time.h:60,
	                 from ./include/linux/skbuff.h:15,
	                 from ./include/linux/if_ether.h:19,
	                 from ./include/linux/habanalabs/cpucp_if.h:12,
	                 from drivers/accel/habanalabs/common/habanalabs.h:11,
	                 from drivers/accel/habanalabs/common/habanalabs_ioctl.c:11:
	./include/asm-generic/timex.h:8:23: note: previous declaration of =E2=80=98c=
ycles_t=E2=80=99 with type =E2=80=98cycles_t=E2=80=99 {aka =E2=80=98long unsi=
gned int=E2=80=99}
	    8 | typedef unsigned long cycles_t;
	      |                       ^~~~~~~~

To resolve these kinds of problems and to allow <asm/tsc.h> to be included on=
 UML,
add a simplified version of <asm/tsc.h>, which only adds the rdtsc() definiti=
on.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/r/202505080003.0t7ewxGp-lkp@intel.com
---
 arch/um/include/asm/tsc.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 arch/um/include/asm/tsc.h

diff --git a/arch/um/include/asm/tsc.h b/arch/um/include/asm/tsc.h
new file mode 100644
index 0000000..a52b0e4
--- /dev/null
+++ b/arch/um/include/asm/tsc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UM_TSC_H
+#define _ASM_UM_TSC_H
+
+#include <asm/asm.h>
+
+/**
+ * rdtsc() - returns the current TSC without ordering constraints
+ *
+ * rdtsc() returns the result of RDTSC as a 64-bit integer.  The
+ * only ordering constraint it supplies is the ordering implied by
+ * "asm volatile": it will put the RDTSC in the place you expect.  The
+ * CPU can and will speculatively execute that RDTSC, though, so the
+ * results can be non-monotonic if compared on different CPUs.
+ */
+static __always_inline u64 rdtsc(void)
+{
+	EAX_EDX_DECLARE_ARGS(val, low, high);
+
+	asm volatile("rdtsc" : EAX_EDX_RET(val, low, high));
+
+	return EAX_EDX_VAL(val, low, high);
+}
+
+#endif /* _ASM_UM_TSC_H */

