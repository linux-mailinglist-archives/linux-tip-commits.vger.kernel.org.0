Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248512B82EF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgKRRSg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgKRRSd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:33 -0500
Date:   Wed, 18 Nov 2020 17:18:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKqHkekGhn9fFeSB83dA0fHqm9yJFPwQnSrQi9G7lcc=;
        b=ruvIIux9fUy7fJAhp0GFSYi/H7EoSkAn4JiLwDMXf/jIdp7sCP5f6fOfX6ccT1T+IgCF4d
        qmdoh81iaTRK0ACK7wtkG98vP+E224d+A04x4MBkYdbMRc1GAGZIMRCdE1LFX3JAoC2HgM
        UtAaaKTTxKF+/wIKTXxYDWGMq7znKHC3yNkJdLVANUE8/xuroQ3rKJotMDcxgmShTqZ9zw
        G6dnycIp202hrfOKyBskRNjZA+pXzJ8Iv00aokU33Ey75WlUejk0SlhG9+PbabbNAotXwQ
        4wrt5X9eZr6IjpNyvZdwkmNDeEe3FxnnSns2dOUzvMMPkutx4186OjaC7ZviAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKqHkekGhn9fFeSB83dA0fHqm9yJFPwQnSrQi9G7lcc=;
        b=9mui/K0gy1TZSQKhx/pmNIWzDhSbthAtmad6yhyOOswrFG8UD5LFuEVjbK1vSC7q7pdFAs
        LAuaBIehpHBjk4Bg==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add wrappers for ENCLS functions
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-3-jarkko@kernel.org>
References: <20201112220135.165028-3-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990944.11244.17428577745123491200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     2c273671d0dfcf89c9c8a319ed093406e3ff665c
Gitweb:        https://git.kernel.org/tip/2c273671d0dfcf89c9c8a319ed093406e3f=
f665c
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 00:01:13 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Nov 2020 14:36:12 +01:00

x86/sgx: Add wrappers for ENCLS functions

ENCLS is the userspace instruction which wraps virtually all
unprivileged SGX functionality for managing enclaves.  It is essentially
the ioctl() of instructions with each function implementing different
SGX-related functionality.

Add macros to wrap the ENCLS functionality. There are two main groups,
one for functions which do not return error codes and a =E2=80=9Cret_=E2=80=
=9D set for
those that do.

ENCLS functions are documented in Intel SDM section 36.6.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-3-jarkko@kernel.org
---
 arch/x86/kernel/cpu/sgx/encls.h | 231 +++++++++++++++++++++++++++++++-
 1 file changed, 231 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/sgx/encls.h

diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
new file mode 100644
index 0000000..443188f
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -0,0 +1,231 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _X86_ENCLS_H
+#define _X86_ENCLS_H
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/rwsem.h>
+#include <linux/types.h>
+#include <asm/asm.h>
+#include <asm/traps.h>
+#include "sgx.h"
+
+enum sgx_encls_function {
+	ECREATE	=3D 0x00,
+	EADD	=3D 0x01,
+	EINIT	=3D 0x02,
+	EREMOVE	=3D 0x03,
+	EDGBRD	=3D 0x04,
+	EDGBWR	=3D 0x05,
+	EEXTEND	=3D 0x06,
+	ELDU	=3D 0x08,
+	EBLOCK	=3D 0x09,
+	EPA	=3D 0x0A,
+	EWB	=3D 0x0B,
+	ETRACK	=3D 0x0C,
+};
+
+/**
+ * ENCLS_FAULT_FLAG - flag signifying an ENCLS return code is a trapnr
+ *
+ * ENCLS has its own (positive value) error codes and also generates
+ * ENCLS specific #GP and #PF faults.  And the ENCLS values get munged
+ * with system error codes as everything percolates back up the stack.
+ * Unfortunately (for us), we need to precisely identify each unique
+ * error code, e.g. the action taken if EWB fails varies based on the
+ * type of fault and on the exact SGX error code, i.e. we can't simply
+ * convert all faults to -EFAULT.
+ *
+ * To make all three error types coexist, we set bit 30 to identify an
+ * ENCLS fault.  Bit 31 (technically bits N:31) is used to differentiate
+ * between positive (faults and SGX error codes) and negative (system
+ * error codes) values.
+ */
+#define ENCLS_FAULT_FLAG 0x40000000
+
+/* Retrieve the encoded trapnr from the specified return code. */
+#define ENCLS_TRAPNR(r) ((r) & ~ENCLS_FAULT_FLAG)
+
+/* Issue a WARN() about an ENCLS function. */
+#define ENCLS_WARN(r, name) {						  \
+	do {								  \
+		int _r =3D (r);						  \
+		WARN_ONCE(_r, "%s returned %d (0x%x)\n", (name), _r, _r); \
+	} while (0);							  \
+}
+
+/**
+ * encls_failed() - Check if an ENCLS function failed
+ * @ret:	the return value of an ENCLS function call
+ *
+ * Check if an ENCLS function failed. This happens when the function causes a
+ * fault that is not caused by an EPCM conflict or when the function returns=
 a
+ * non-zero value.
+ */
+static inline bool encls_failed(int ret)
+{
+	if (ret & ENCLS_FAULT_FLAG)
+		return ENCLS_TRAPNR(ret) !=3D X86_TRAP_PF;
+
+	return !!ret;
+}
+
+/**
+ * __encls_ret_N - encode an ENCLS function that returns an error code in EAX
+ * @rax:	function number
+ * @inputs:	asm inputs for the function
+ *
+ * Emit assembly for an ENCLS function that returns an error code, e.g. EREM=
OVE.
+ * And because SGX isn't complex enough as it is, function that return an er=
ror
+ * code also modify flags.
+ *
+ * Return:
+ *	0 on success,
+ *	SGX error code on failure
+ */
+#define __encls_ret_N(rax, inputs...)				\
+	({							\
+	int ret;						\
+	asm volatile(						\
+	"1: .byte 0x0f, 0x01, 0xcf;\n\t"			\
+	"2:\n"							\
+	".section .fixup,\"ax\"\n"				\
+	"3: orl $"__stringify(ENCLS_FAULT_FLAG)",%%eax\n"	\
+	"   jmp 2b\n"						\
+	".previous\n"						\
+	_ASM_EXTABLE_FAULT(1b, 3b)				\
+	: "=3Da"(ret)						\
+	: "a"(rax), inputs					\
+	: "memory", "cc");					\
+	ret;							\
+	})
+
+#define __encls_ret_1(rax, rcx)		\
+	({				\
+	__encls_ret_N(rax, "c"(rcx));	\
+	})
+
+#define __encls_ret_2(rax, rbx, rcx)		\
+	({					\
+	__encls_ret_N(rax, "b"(rbx), "c"(rcx));	\
+	})
+
+#define __encls_ret_3(rax, rbx, rcx, rdx)			\
+	({							\
+	__encls_ret_N(rax, "b"(rbx), "c"(rcx), "d"(rdx));	\
+	})
+
+/**
+ * __encls_N - encode an ENCLS function that doesn't return an error code
+ * @rax:	function number
+ * @rbx_out:	optional output variable
+ * @inputs:	asm inputs for the function
+ *
+ * Emit assembly for an ENCLS function that does not return an error code, e=
.g.
+ * ECREATE.  Leaves without error codes either succeed or fault.  @rbx_out i=
s an
+ * optional parameter for use by EDGBRD, which returns the requested value in
+ * RBX.
+ *
+ * Return:
+ *   0 on success,
+ *   trapnr with ENCLS_FAULT_FLAG set on fault
+ */
+#define __encls_N(rax, rbx_out, inputs...)			\
+	({							\
+	int ret;						\
+	asm volatile(						\
+	"1: .byte 0x0f, 0x01, 0xcf;\n\t"			\
+	"   xor %%eax,%%eax;\n"					\
+	"2:\n"							\
+	".section .fixup,\"ax\"\n"				\
+	"3: orl $"__stringify(ENCLS_FAULT_FLAG)",%%eax\n"	\
+	"   jmp 2b\n"						\
+	".previous\n"						\
+	_ASM_EXTABLE_FAULT(1b, 3b)				\
+	: "=3Da"(ret), "=3Db"(rbx_out)				\
+	: "a"(rax), inputs					\
+	: "memory");						\
+	ret;							\
+	})
+
+#define __encls_2(rax, rbx, rcx)				\
+	({							\
+	unsigned long ign_rbx_out;				\
+	__encls_N(rax, ign_rbx_out, "b"(rbx), "c"(rcx));	\
+	})
+
+#define __encls_1_1(rax, data, rcx)			\
+	({						\
+	unsigned long rbx_out;				\
+	int ret =3D __encls_N(rax, rbx_out, "c"(rcx));	\
+	if (!ret)					\
+		data =3D rbx_out;				\
+	ret;						\
+	})
+
+static inline int __ecreate(struct sgx_pageinfo *pginfo, void *secs)
+{
+	return __encls_2(ECREATE, pginfo, secs);
+}
+
+static inline int __eextend(void *secs, void *addr)
+{
+	return __encls_2(EEXTEND, secs, addr);
+}
+
+static inline int __eadd(struct sgx_pageinfo *pginfo, void *addr)
+{
+	return __encls_2(EADD, pginfo, addr);
+}
+
+static inline int __einit(void *sigstruct, void *token, void *secs)
+{
+	return __encls_ret_3(EINIT, sigstruct, secs, token);
+}
+
+static inline int __eremove(void *addr)
+{
+	return __encls_ret_1(EREMOVE, addr);
+}
+
+static inline int __edbgwr(void *addr, unsigned long *data)
+{
+	return __encls_2(EDGBWR, *data, addr);
+}
+
+static inline int __edbgrd(void *addr, unsigned long *data)
+{
+	return __encls_1_1(EDGBRD, *data, addr);
+}
+
+static inline int __etrack(void *addr)
+{
+	return __encls_ret_1(ETRACK, addr);
+}
+
+static inline int __eldu(struct sgx_pageinfo *pginfo, void *addr,
+			 void *va)
+{
+	return __encls_ret_3(ELDU, pginfo, addr, va);
+}
+
+static inline int __eblock(void *addr)
+{
+	return __encls_ret_1(EBLOCK, addr);
+}
+
+static inline int __epa(void *addr)
+{
+	unsigned long rbx =3D SGX_PAGE_TYPE_VA;
+
+	return __encls_2(EPA, rbx, addr);
+}
+
+static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
+			void *va)
+{
+	return __encls_ret_3(EWB, pginfo, addr, va);
+}
+
+#endif /* _X86_ENCLS_H */
