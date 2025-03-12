Return-Path: <linux-tip-commits+bounces-4125-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1ECA5D3EB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 02:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004BE3AA470
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 01:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0F433AD;
	Wed, 12 Mar 2025 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="g8zF2C7R"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A785661;
	Wed, 12 Mar 2025 01:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742121; cv=none; b=UClAfumArh5NyeX9tuLOGQtHgkyeDJO7MXErYh/TM73YpFbjK8vO6F8NBRaE1EDP0TO+aF/78tA5wE6FjRR7U9jqn/CSb/XNdaZUEwE0FxZIqR6CiUZZ6XlMqW79vmOHp+VxacoNcivet0bgDKVzWtiV8czL+vxUAsl0swBxFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742121; c=relaxed/simple;
	bh=GdIWn8dxvwQNfNGBlXkzMqFUGUh6OBtumAWEyL1MDcA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KeL4Cqh0nDksWHH9v/+C7QcBwTWqFAWAkZe7HMm7BmjIOMFMQjiD5AP1NqNa8V5ECA7xoueCvvu0U0nSE99s01vOnsxxENr/qKfiqZCfi7uxw1QPcpKN+vMBEl7DhbwQEjiZzzGUfE7YtVzwBefrZQ7UJd5dHwhssIQD6yULZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=g8zF2C7R; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52C1F0M52325286
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Mar 2025 18:15:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52C1F0M52325286
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741742101;
	bh=jlwxRcrns0OIiqdDfKZ4XIvdhyr1zkyGiaDQmjUp31o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=g8zF2C7RkWrC0uYcQ9Z2M9gq17yMYDUMilrqFdg8r7xlBrYpwch8z/WhdNTQbXTFQ
	 PfzRoNASkFpQ8ggEmlTHEHheUxRXBbXKVyfK5cej6+zWJgUeycdxQv0ClwEEnNNffX
	 dy6UmPVgoSpkfZ35nQfFtkOtDEalKtVNXe8TRSuEeY3hLQVdwkVbjQjp3YfAKKYq19
	 kmzJeql9juY2ofucFdMo9EtztmvuUPW3ctL2hsAGLXH5GqecvvHhRetEdlZ/wG2hU+
	 J8XFh8EnXgYfHBjs6recrm8KcS3diM1IKRusX5w1ib0rlfmoNnxqyYNxPMpjT1QOIY
	 hqWP2AQl40Xug==
Date: Tue, 11 Mar 2025 18:15:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org,
        tip-bot2 for Thomas Huth <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
CC: Thomas Huth <thuth@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>,
        x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/headers=5D_x86/headers=3A_Replace_=5F?=
 =?US-ASCII?Q?=5FASSEMBLY=5F=5F_with_=5F=5FASSEMBLER=5F=5F_in_UAPI_headers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <174160617464.14745.3081665054786018758.tip-bot2@tip-bot2>
References: <20250310104256.123527-1-thuth@redhat.com> <174160617464.14745.3081665054786018758.tip-bot2@tip-bot2>
Message-ID: <B004CC50-5077-44A2-9EC9-6444BBA400A8@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 10, 2025 4:29:34 AM PDT, tip-bot2 for Thomas Huth <tip-bot2@linutr=
onix=2Ede> wrote:
>The following commit has been merged into the x86/headers branch of tip:
>
>Commit-ID:     e28eecf2602bdce826833ccb9a6b7a6bacafd98b
>Gitweb:        https://git=2Ekernel=2Eorg/tip/e28eecf2602bdce826833ccb9a6=
b7a6bacafd98b
>Author:        Thomas Huth <thuth@redhat=2Ecom>
>AuthorDate:    Mon, 10 Mar 2025 11:42:56 +01:00
>Committer:     Ingo Molnar <mingo@kernel=2Eorg>
>CommitterDate: Mon, 10 Mar 2025 12:18:42 +01:00
>
>x86/headers: Replace __ASSEMBLY__ with __ASSEMBLER__ in UAPI headers
>
>__ASSEMBLY__ is only defined by the Makefile of the kernel, so
>this is not really useful for UAPI headers (unless the userspace
>Makefile defines it, too)=2E Let's switch to __ASSEMBLER__ which
>gets set automatically by the compiler when compiling assembly
>code=2E
>
>Signed-off-by: Thomas Huth <thuth@redhat=2Ecom>
>Signed-off-by: Ingo Molnar <mingo@kernel=2Eorg>
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>Cc: Linus Torvalds <torvalds@linux-foundation=2Eorg>
>Cc: Kees Cook <keescook@chromium=2Eorg>
>Cc: Brian Gerst <brgerst@gmail=2Ecom>
>Link: https://lore=2Ekernel=2Eorg/r/20250310104256=2E123527-1-thuth@redha=
t=2Ecom
>---
> arch/x86/include/uapi/asm/bootparam=2Eh  | 4 ++--
> arch/x86/include/uapi/asm/e820=2Eh       | 4 ++--
> arch/x86/include/uapi/asm/ldt=2Eh        | 4 ++--
> arch/x86/include/uapi/asm/msr=2Eh        | 4 ++--
> arch/x86/include/uapi/asm/ptrace-abi=2Eh | 6 +++---
> arch/x86/include/uapi/asm/ptrace=2Eh     | 4 ++--
> arch/x86/include/uapi/asm/setup_data=2Eh | 4 ++--
> arch/x86/include/uapi/asm/signal=2Eh     | 8 ++++----
> 8 files changed, 19 insertions(+), 19 deletions(-)
>
>diff --git a/arch/x86/include/uapi/asm/bootparam=2Eh b/arch/x86/include/u=
api/asm/bootparam=2Eh
>index 9b82eeb=2E=2Edafbf58 100644
>--- a/arch/x86/include/uapi/asm/bootparam=2Eh
>+++ b/arch/x86/include/uapi/asm/bootparam=2Eh
>@@ -26,7 +26,7 @@
> #define XLF_5LEVEL_ENABLED		(1<<6)
> #define XLF_MEM_ENCRYPTION		(1<<7)
>=20
>-#ifndef __ASSEMBLY__
>+#ifndef __ASSEMBLER__
>=20
> #include <linux/types=2Eh>
> #include <linux/screen_info=2Eh>
>@@ -210,6 +210,6 @@ enum x86_hardware_subarch {
> 	X86_NR_SUBARCHS,
> };
>=20
>-#endif /* __ASSEMBLY__ */
>+#endif /* __ASSEMBLER__ */
>=20
> #endif /* _ASM_X86_BOOTPARAM_H */
>diff --git a/arch/x86/include/uapi/asm/e820=2Eh b/arch/x86/include/uapi/a=
sm/e820=2Eh
>index 2f491ef=2E=2E55bc668 100644
>--- a/arch/x86/include/uapi/asm/e820=2Eh
>+++ b/arch/x86/include/uapi/asm/e820=2Eh
>@@ -54,7 +54,7 @@
>  */
> #define E820_RESERVED_KERN        128
>=20
>-#ifndef __ASSEMBLY__
>+#ifndef __ASSEMBLER__
> #include <linux/types=2Eh>
> struct e820entry {
> 	__u64 addr;	/* start of memory segment */
>@@ -76,7 +76,7 @@ struct e820map {
> #define BIOS_ROM_BASE		0xffe00000
> #define BIOS_ROM_END		0xffffffff
>=20
>-#endif /* __ASSEMBLY__ */
>+#endif /* __ASSEMBLER__ */
>=20
>=20
> #endif /* _UAPI_ASM_X86_E820_H */
>diff --git a/arch/x86/include/uapi/asm/ldt=2Eh b/arch/x86/include/uapi/as=
m/ldt=2Eh
>index d62ac5d=2E=2Ea82c039 100644
>--- a/arch/x86/include/uapi/asm/ldt=2Eh
>+++ b/arch/x86/include/uapi/asm/ldt=2Eh
>@@ -12,7 +12,7 @@
> /* The size of each LDT entry=2E */
> #define LDT_ENTRY_SIZE	8
>=20
>-#ifndef __ASSEMBLY__
>+#ifndef __ASSEMBLER__
> /*
>  * Note on 64bit base and limit is ignored and you cannot set DS/ES/CS
>  * not to the default values if you still want to do syscalls=2E This
>@@ -44,5 +44,5 @@ struct user_desc {
> #define MODIFY_LDT_CONTENTS_STACK	1
> #define MODIFY_LDT_CONTENTS_CODE	2
>=20
>-#endif /* !__ASSEMBLY__ */
>+#endif /* !__ASSEMBLER__ */
> #endif /* _ASM_X86_LDT_H */
>diff --git a/arch/x86/include/uapi/asm/msr=2Eh b/arch/x86/include/uapi/as=
m/msr=2Eh
>index e7516b4=2E=2E4b8917c 100644
>--- a/arch/x86/include/uapi/asm/msr=2Eh
>+++ b/arch/x86/include/uapi/asm/msr=2Eh
>@@ -2,7 +2,7 @@
> #ifndef _UAPI_ASM_X86_MSR_H
> #define _UAPI_ASM_X86_MSR_H
>=20
>-#ifndef __ASSEMBLY__
>+#ifndef __ASSEMBLER__
>=20
> #include <linux/types=2Eh>
> #include <linux/ioctl=2Eh>
>@@ -10,5 +10,5 @@
> #define X86_IOC_RDMSR_REGS	_IOWR('c', 0xA0, __u32[8])
> #define X86_IOC_WRMSR_REGS	_IOWR('c', 0xA1, __u32[8])
>=20
>-#endif /* __ASSEMBLY__ */
>+#endif /* __ASSEMBLER__ */
> #endif /* _UAPI_ASM_X86_MSR_H */
>diff --git a/arch/x86/include/uapi/asm/ptrace-abi=2Eh b/arch/x86/include/=
uapi/asm/ptrace-abi=2Eh
>index 16074b9=2E=2E5823584 100644
>--- a/arch/x86/include/uapi/asm/ptrace-abi=2Eh
>+++ b/arch/x86/include/uapi/asm/ptrace-abi=2Eh
>@@ -25,7 +25,7 @@
>=20
> #else /* __i386__ */
>=20
>-#if defined(__ASSEMBLY__) || defined(__FRAME_OFFSETS)
>+#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)
> /*
>  * C ABI says these regs are callee-preserved=2E They aren't saved on ke=
rnel entry
>  * unless syscall needs a complete, fully filled "struct pt_regs"=2E
>@@ -57,7 +57,7 @@
> #define EFLAGS 144
> #define RSP 152
> #define SS 160
>-#endif /* __ASSEMBLY__ */
>+#endif /* __ASSEMBLER__ */
>=20
> /* top of stack page */
> #define FRAME_SIZE 168
>@@ -87,7 +87,7 @@
>=20
> #define PTRACE_SINGLEBLOCK	33	/* resume execution until next branch */
>=20
>-#ifndef __ASSEMBLY__
>+#ifndef __ASSEMBLER__
> #include <linux/types=2Eh>
> #endif
>=20
>diff --git a/arch/x86/include/uapi/asm/ptrace=2Eh b/arch/x86/include/uapi=
/asm/ptrace=2Eh
>index 85165c0=2E=2Ee0b5b4f 100644
>--- a/arch/x86/include/uapi/asm/ptrace=2Eh
>+++ b/arch/x86/include/uapi/asm/ptrace=2Eh
>@@ -7,7 +7,7 @@
> #include <asm/processor-flags=2Eh>
>=20
>=20
>-#ifndef __ASSEMBLY__
>+#ifndef __ASSEMBLER__
>=20
> #ifdef __i386__
> /* this struct defines the way the registers are stored on the
>@@ -81,6 +81,6 @@ struct pt_regs {
>=20
>=20
>=20
>-#endif /* !__ASSEMBLY__ */
>+#endif /* !__ASSEMBLER__ */
>=20
> #endif /* _UAPI_ASM_X86_PTRACE_H */
>diff --git a/arch/x86/include/uapi/asm/setup_data=2Eh b/arch/x86/include/=
uapi/asm/setup_data=2Eh
>index b111b0c=2E=2E50c45ea 100644
>--- a/arch/x86/include/uapi/asm/setup_data=2Eh
>+++ b/arch/x86/include/uapi/asm/setup_data=2Eh
>@@ -18,7 +18,7 @@
> #define SETUP_INDIRECT			(1<<31)
> #define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
>=20
>-#ifndef __ASSEMBLY__
>+#ifndef __ASSEMBLER__
>=20
> #include <linux/types=2Eh>
>=20
>@@ -78,6 +78,6 @@ struct ima_setup_data {
> 	__u64 size;
> } __attribute__((packed));
>=20
>-#endif /* __ASSEMBLY__ */
>+#endif /* __ASSEMBLER__ */
>=20
> #endif /* _UAPI_ASM_X86_SETUP_DATA_H */
>diff --git a/arch/x86/include/uapi/asm/signal=2Eh b/arch/x86/include/uapi=
/asm/signal=2Eh
>index f777346=2E=2E1067efa 100644
>--- a/arch/x86/include/uapi/asm/signal=2Eh
>+++ b/arch/x86/include/uapi/asm/signal=2Eh
>@@ -2,7 +2,7 @@
> #ifndef _UAPI_ASM_X86_SIGNAL_H
> #define _UAPI_ASM_X86_SIGNAL_H
>=20
>-#ifndef __ASSEMBLY__
>+#ifndef __ASSEMBLER__
> #include <linux/types=2Eh>
> #include <linux/compiler=2Eh>
>=20
>@@ -16,7 +16,7 @@ struct siginfo;
> typedef unsigned long sigset_t;
>=20
> #endif /* __KERNEL__ */
>-#endif /* __ASSEMBLY__ */
>+#endif /* __ASSEMBLER__ */
>=20
>=20
> #define SIGHUP		 1
>@@ -68,7 +68,7 @@ typedef unsigned long sigset_t;
>=20
> #include <asm-generic/signal-defs=2Eh>
>=20
>-#ifndef __ASSEMBLY__
>+#ifndef __ASSEMBLER__
>=20
>=20
> # ifndef __KERNEL__
>@@ -106,6 +106,6 @@ typedef struct sigaltstack {
> 	__kernel_size_t ss_size;
> } stack_t;
>=20
>-#endif /* __ASSEMBLY__ */
>+#endif /* __ASSEMBLER__ */
>=20
> #endif /* _UAPI_ASM_X86_SIGNAL_H */

Wouldn't it be better to replace this everywhere for consistency?

