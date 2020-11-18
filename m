Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6C2B830E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgKRRT3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgKRRSW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC806C0613D4;
        Wed, 18 Nov 2020 09:18:21 -0800 (PST)
Date:   Wed, 18 Nov 2020 17:18:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719900;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4GVuPlvtvMTjOv8khZoVmW93kLHYYDYSEc8Hg9ytkYg=;
        b=rS8ss2707hW/kpHYwsyjZhSMLy6ID0X4N5QWQHoFnKGN5/Sj8N8ERS38ZBFoEwCcW3ytl2
        SPrqpVWGx9tzdN/9+dzRv9woTONH7T4LfN8jPSrl9PHjVV1skzc2LfP3RyrAsMXctoOZbr
        YEI24C/I5s4VIgYplx8ZABiQ8QdP/3aCJO1CG1JfUqXBYciYlGmf15aw2pyr/AFaTpf/wG
        KY0Oq0Czu8+i5cLNvLYnQ8al3IHAvGcRdv7VyZ42ZIwfiKFiJMfGDe3c+mYZhY1F4aVUxh
        ywzlW6t2tqkqdyYQpkwfqezIFr/yW+H3HPKVlqjtNKZBkSMQ8A+2C97ZStOJFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719900;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4GVuPlvtvMTjOv8khZoVmW93kLHYYDYSEc8Hg9ytkYg=;
        b=svKTLQC4DmeP6agYS0omRAmSPbmZ+vVI8kZM5X9lu3AozhZjgRnM8jF11sUsiLeu+0Kv5q
        VJYZZxeYuh6JmLDA==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/vdso: Implement a vDSO for Intel SGX enclave call
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-20-jarkko@kernel.org>
References: <20201112220135.165028-20-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571989928.11244.11441639225973142154.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     84664369520170f48546c55cbc1f3fbde9b1e140
Gitweb:        https://git.kernel.org/tip/84664369520170f48546c55cbc1f3fbde9b=
1e140
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 13 Nov 2020 00:01:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:02:50 +01:00

x86/vdso: Implement a vDSO for Intel SGX enclave call

Enclaves encounter exceptions for lots of reasons: everything from enclave
page faults to NULL pointer dereferences, to system calls that must be
=E2=80=9Cproxied=E2=80=9D to the kernel from outside the enclave.

In addition to the code contained inside an enclave, there is also
supporting code outside the enclave called an =E2=80=9CSGX runtime=E2=80=9D, =
which is
virtually always implemented inside a shared library.  The runtime helps
build the enclave and handles things like *re*building the enclave if it
got destroyed by something like a suspend/resume cycle.

The rebuilding has traditionally been handled in SIGSEGV handlers,
registered by the library.  But, being process-wide, shared state, signal
handling and shared libraries do not mix well.

Introduce a vDSO function call that wraps the enclave entry functions
(EENTER/ERESUME functions of the ENCLU instruciton) and returns information
about any exceptions to the caller in the SGX runtime.

Instead of generating a signal, the kernel places exception information in
RDI, RSI and RDX. The kernel-provided userspace portion of the vDSO handler
will place this information in a user-provided buffer or trigger a
user-provided callback at the time of the exception.

The vDSO function calling convention uses the standard RDI RSI, RDX, RCX,
R8 and R9 registers.  This makes it possible to declare the vDSO as a C
prototype, but other than that there is no specific support for SystemV
ABI. Things like storing XSAVE are the responsibility of the enclave and
the runtime.

 [ bp: Change vsgx.o build dependency to CONFIG_X86_SGX. ]

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Cedric Xing <cedric.xing@intel.com>
Signed-off-by: Cedric Xing <cedric.xing@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-20-jarkko@kernel.org
---
 arch/x86/entry/vdso/Makefile    |   2 +-
 arch/x86/entry/vdso/vdso.lds.S  |   1 +-
 arch/x86/entry/vdso/vsgx.S      | 151 +++++++++++++++++++++++++++++++-
 arch/x86/include/asm/enclu.h    |   9 ++-
 arch/x86/include/uapi/asm/sgx.h |  91 +++++++++++++++++++-
 5 files changed, 254 insertions(+)
 create mode 100644 arch/x86/entry/vdso/vsgx.S
 create mode 100644 arch/x86/include/asm/enclu.h

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 2ad757f..02e3e42 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -27,6 +27,7 @@ VDSO32-$(CONFIG_IA32_EMULATION)	:=3D y
 vobjs-y :=3D vdso-note.o vclock_gettime.o vgetcpu.o
 vobjs32-y :=3D vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
 vobjs32-y +=3D vdso32/vclock_gettime.o
+vobjs-$(CONFIG_X86_SGX)	+=3D vsgx.o
=20
 # files to link into kernel
 obj-y				+=3D vma.o extable.o
@@ -98,6 +99,7 @@ $(vobjs): KBUILD_CFLAGS :=3D $(filter-out $(GCC_PLUGINS_CFL=
AGS) $(RETPOLINE_CFLAGS
 CFLAGS_REMOVE_vclock_gettime.o =3D -pg
 CFLAGS_REMOVE_vdso32/vclock_gettime.o =3D -pg
 CFLAGS_REMOVE_vgetcpu.o =3D -pg
+CFLAGS_REMOVE_vsgx.o =3D -pg
=20
 #
 # X32 processes use x32 vDSO to access 64bit kernel data.
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index 36b644e..4bf4846 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -27,6 +27,7 @@ VERSION {
 		__vdso_time;
 		clock_getres;
 		__vdso_clock_getres;
+		__vdso_sgx_enter_enclave;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
new file mode 100644
index 0000000..86a0e94
--- /dev/null
+++ b/arch/x86/entry/vdso/vsgx.S
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/export.h>
+#include <asm/errno.h>
+#include <asm/enclu.h>
+
+#include "extable.h"
+
+/* Relative to %rbp. */
+#define SGX_ENCLAVE_OFFSET_OF_RUN		16
+
+/* The offsets relative to struct sgx_enclave_run. */
+#define SGX_ENCLAVE_RUN_TCS			0
+#define SGX_ENCLAVE_RUN_LEAF			8
+#define SGX_ENCLAVE_RUN_EXCEPTION_VECTOR	12
+#define SGX_ENCLAVE_RUN_EXCEPTION_ERROR_CODE	14
+#define SGX_ENCLAVE_RUN_EXCEPTION_ADDR		16
+#define SGX_ENCLAVE_RUN_USER_HANDLER		24
+#define SGX_ENCLAVE_RUN_USER_DATA		32	/* not used */
+#define SGX_ENCLAVE_RUN_RESERVED_START		40
+#define SGX_ENCLAVE_RUN_RESERVED_END		256
+
+.code64
+.section .text, "ax"
+
+SYM_FUNC_START(__vdso_sgx_enter_enclave)
+	/* Prolog */
+	.cfi_startproc
+	push	%rbp
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%rbp, 0
+	mov	%rsp, %rbp
+	.cfi_def_cfa_register	%rbp
+	push	%rbx
+	.cfi_rel_offset		%rbx, -8
+
+	mov	%ecx, %eax
+.Lenter_enclave:
+	/* EENTER <=3D function <=3D ERESUME */
+	cmp	$EENTER, %eax
+	jb	.Linvalid_input
+	cmp	$ERESUME, %eax
+	ja	.Linvalid_input
+
+	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rcx
+
+	/* Validate that the reserved area contains only zeros. */
+	mov	$SGX_ENCLAVE_RUN_RESERVED_START, %rbx
+1:
+	cmpq	$0, (%rcx, %rbx)
+	jne	.Linvalid_input
+	add	$8, %rbx
+	cmpq	$SGX_ENCLAVE_RUN_RESERVED_END, %rbx
+	jne	1b
+
+	/* Load TCS and AEP */
+	mov	SGX_ENCLAVE_RUN_TCS(%rcx), %rbx
+	lea	.Lasync_exit_pointer(%rip), %rcx
+
+	/* Single ENCLU serving as both EENTER and AEP (ERESUME) */
+.Lasync_exit_pointer:
+.Lenclu_eenter_eresume:
+	enclu
+
+	/* EEXIT jumps here unless the enclave is doing something fancy. */
+	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
+
+	/* Set exit_reason. */
+	movl	$EEXIT, SGX_ENCLAVE_RUN_LEAF(%rbx)
+
+	/* Invoke userspace's exit handler if one was provided. */
+.Lhandle_exit:
+	cmpq	$0, SGX_ENCLAVE_RUN_USER_HANDLER(%rbx)
+	jne	.Linvoke_userspace_handler
+
+	/* Success, in the sense that ENCLU was attempted. */
+	xor	%eax, %eax
+
+.Lout:
+	pop	%rbx
+	leave
+	.cfi_def_cfa		%rsp, 8
+	ret
+
+	/* The out-of-line code runs with the pre-leave stack frame. */
+	.cfi_def_cfa		%rbp, 16
+
+.Linvalid_input:
+	mov	$(-EINVAL), %eax
+	jmp	.Lout
+
+.Lhandle_exception:
+	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
+
+	/* Set the exception info. */
+	mov	%eax, (SGX_ENCLAVE_RUN_LEAF)(%rbx)
+	mov	%di,  (SGX_ENCLAVE_RUN_EXCEPTION_VECTOR)(%rbx)
+	mov	%si,  (SGX_ENCLAVE_RUN_EXCEPTION_ERROR_CODE)(%rbx)
+	mov	%rdx, (SGX_ENCLAVE_RUN_EXCEPTION_ADDR)(%rbx)
+	jmp	.Lhandle_exit
+
+.Linvoke_userspace_handler:
+	/* Pass the untrusted RSP (at exit) to the callback via %rcx. */
+	mov	%rsp, %rcx
+
+	/* Save struct sgx_enclave_exception %rbx is about to be clobbered. */
+	mov	%rbx, %rax
+
+	/* Save the untrusted RSP offset in %rbx (non-volatile register). */
+	mov	%rsp, %rbx
+	and	$0xf, %rbx
+
+	/*
+	 * Align stack per x86_64 ABI. Note, %rsp needs to be 16-byte aligned
+	 * _after_ pushing the parameters on the stack, hence the bonus push.
+	 */
+	and	$-0x10, %rsp
+	push	%rax
+
+	/* Push struct sgx_enclave_exception as a param to the callback. */
+	push	%rax
+
+	/* Clear RFLAGS.DF per x86_64 ABI */
+	cld
+
+	/*
+	 * Load the callback pointer to %rax and lfence for LVI (load value
+	 * injection) protection before making the call.
+	 */
+	mov	SGX_ENCLAVE_RUN_USER_HANDLER(%rax), %rax
+	lfence
+	call	*%rax
+
+	/* Undo the post-exit %rsp adjustment. */
+	lea	0x10(%rsp, %rbx), %rsp
+
+	/*
+	 * If the return from callback is zero or negative, return immediately,
+	 * else re-execute ENCLU with the postive return value interpreted as
+	 * the requested ENCLU function.
+	 */
+	cmp	$0, %eax
+	jle	.Lout
+	jmp	.Lenter_enclave
+
+	.cfi_endproc
+
+_ASM_VDSO_EXTABLE_HANDLE(.Lenclu_eenter_eresume, .Lhandle_exception)
+
+SYM_FUNC_END(__vdso_sgx_enter_enclave)
diff --git a/arch/x86/include/asm/enclu.h b/arch/x86/include/asm/enclu.h
new file mode 100644
index 0000000..b1314e4
--- /dev/null
+++ b/arch/x86/include/asm/enclu.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ENCLU_H
+#define _ASM_X86_ENCLU_H
+
+#define EENTER	0x02
+#define ERESUME	0x03
+#define EEXIT	0x04
+
+#endif /* _ASM_X86_ENCLU_H */
diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index c322102..791e453 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -74,4 +74,95 @@ struct sgx_enclave_provision {
 	__u64 fd;
 };
=20
+struct sgx_enclave_run;
+
+/**
+ * typedef sgx_enclave_user_handler_t - Exit handler function accepted by
+ *					__vdso_sgx_enter_enclave()
+ * @run:	The run instance given by the caller
+ *
+ * The register parameters contain the snapshot of their values at enclave
+ * exit. An invalid ENCLU function number will cause -EINVAL to be returned
+ * to the caller.
+ *
+ * Return:
+ * - <=3D 0:	The given value is returned back to the caller.
+ * - > 0:	ENCLU function to invoke, either EENTER or ERESUME.
+ */
+typedef int (*sgx_enclave_user_handler_t)(long rdi, long rsi, long rdx,
+					  long rsp, long r8, long r9,
+					  struct sgx_enclave_run *run);
+
+/**
+ * struct sgx_enclave_run - the execution context of __vdso_sgx_enter_enclav=
e()
+ * @tcs:			TCS used to enter the enclave
+ * @function:			The last seen ENCLU function (EENTER, ERESUME or EEXIT)
+ * @exception_vector:		The interrupt vector of the exception
+ * @exception_error_code:	The exception error code pulled out of the stack
+ * @exception_addr:		The address that triggered the exception
+ * @user_handler:		User provided callback run on exception
+ * @user_data:			Data passed to the user handler
+ * @reserved			Reserved for future extensions
+ *
+ * If @user_handler is provided, the handler will be invoked on all return p=
aths
+ * of the normal flow.  The user handler may transfer control, e.g. via a
+ * longjmp() call or a C++ exception, without returning to
+ * __vdso_sgx_enter_enclave().
+ */
+struct sgx_enclave_run {
+	__u64 tcs;
+	__u32 function;
+	__u16 exception_vector;
+	__u16 exception_error_code;
+	__u64 exception_addr;
+	__u64 user_handler;
+	__u64 user_data;
+	__u8  reserved[216];
+};
+
+/**
+ * typedef vdso_sgx_enter_enclave_t - Prototype for __vdso_sgx_enter_enclave=
(),
+ *				      a vDSO function to enter an SGX enclave.
+ * @rdi:	Pass-through value for RDI
+ * @rsi:	Pass-through value for RSI
+ * @rdx:	Pass-through value for RDX
+ * @function:	ENCLU function, must be EENTER or ERESUME
+ * @r8:		Pass-through value for R8
+ * @r9:		Pass-through value for R9
+ * @run:	struct sgx_enclave_run, must be non-NULL
+ *
+ * NOTE: __vdso_sgx_enter_enclave() does not ensure full compliance with the
+ * x86-64 ABI, e.g. doesn't handle XSAVE state.  Except for non-volatile
+ * general purpose registers, EFLAGS.DF, and RSP alignment, preserving/setti=
ng
+ * state in accordance with the x86-64 ABI is the responsibility of the encl=
ave
+ * and its runtime, i.e. __vdso_sgx_enter_enclave() cannot be called from C
+ * code without careful consideration by both the enclave and its runtime.
+ *
+ * All general purpose registers except RAX, RBX and RCX are passed as-is to=
 the
+ * enclave.  RAX, RBX and RCX are consumed by EENTER and ERESUME and are loa=
ded
+ * with @function, asynchronous exit pointer, and @run.tcs respectively.
+ *
+ * RBP and the stack are used to anchor __vdso_sgx_enter_enclave() to the
+ * pre-enclave state, e.g. to retrieve @run.exception and @run.user_handler
+ * after an enclave exit.  All other registers are available for use by the
+ * enclave and its runtime, e.g. an enclave can push additional data onto the
+ * stack (and modify RSP) to pass information to the optional user handler (=
see
+ * below).
+ *
+ * Most exceptions reported on ENCLU, including those that occur within the
+ * enclave, are fixed up and reported synchronously instead of being deliver=
ed
+ * via a standard signal. Debug Exceptions (#DB) and Breakpoints (#BP) are
+ * never fixed up and are always delivered via standard signals. On synchrou=
sly
+ * reported exceptions, -EFAULT is returned and details about the exception =
are
+ * recorded in @run.exception, the optional sgx_enclave_exception struct.
+ *
+ * Return:
+ * - 0:		ENCLU function was successfully executed.
+ * - -EINVAL:	Invalid ENCL number (neither EENTER nor ERESUME).
+ */
+typedef int (*vdso_sgx_enter_enclave_t)(unsigned long rdi, unsigned long rsi,
+					unsigned long rdx, unsigned int function,
+					unsigned long r8,  unsigned long r9,
+					struct sgx_enclave_run *run);
+
 #endif /* _UAPI_ASM_X86_SGX_H */
