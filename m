Return-Path: <linux-tip-commits+bounces-7630-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B14CB84ED
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 09:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71135301FF6B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 08:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F4D25A33A;
	Fri, 12 Dec 2025 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NXtl5U55";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4wogdVM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3525202F71;
	Fri, 12 Dec 2025 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529194; cv=none; b=UHK6lCw1SiZt70GHJ5+ysa5u9tM63FfgzXzuppOxt90PDKj4m6jsKLUWfpfGK3BZ0EV43R3qN3UOLWOQqksitNcdSK+QvyEHv0Rk9XiROYmNGQTv4rgMq5wL4kJ5ba9s88o5xbNx4CpAfZzsqdqw3owWr3+36JUsLb6tNkYHdcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529194; c=relaxed/simple;
	bh=aIyzyJ/9xpEdWJVWRq3Ux1SCaPt3HAKJdrXqT6/E+5c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=adi1Knqu3UU6LvXVPr4dyoz110kKAmXlSWuz1rAsZfK8aWZlblbOokWuFsFx2Ny1eRxFc35EuGo49IBIZjWtlurD1DEd2RoQP4OAHlEcoLZazGhjyROzpNiXdEeCq45NvTNAng8GdU907/Yo/C90YhlBYVcKnFYifa3RYDg1roo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NXtl5U55; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J4wogdVM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Dec 2025 08:46:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765529191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNcuqKPJJoFECNbNhhELjJMo+kbEHOEX/0zfZPmpDHU=;
	b=NXtl5U55WOVHsisuTrCItKFI5m02/N7pYJ+ESwJYjlP9kR8z6ayyd+Q5J2/UaMmjn3Ugv+
	lHksSDQ7ckxBqg06ufUdkgW/wBQZ5fevA6RWyUtxzdMTpQY+Jw6c5CNDn5P2LVdMLWeT4R
	7ShCMK+oa0WUvNaizM33X+gs3b737tlWHXsusQhhiqMniWitrWW2mUBn2EM88oaix3DQFT
	dPgr/hxIG+wibxm1hSH5b1DU7PiT2fcArOJIMft18luDhidA+VYKedYArcYkPW8w0JU7nt
	KUlR24n2euRw/qoCZ5q4mLQ9fnDaj6nf1hBLZ459HBF2GBC1j/G+RHQIu/zyqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765529191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNcuqKPJJoFECNbNhhELjJMo+kbEHOEX/0zfZPmpDHU=;
	b=J4wogdVMME7v1eOAoc9TEVPZobknDTSFwPK+6cTXmMZiVkETB2//Rq0YGOy1BnzIvv+U7D
	V1UlguYUNbsTkRAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/boot/Documentation: Fix whitespace noise in boot.rst
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <176535283007.498.16442167388418039352.tip-bot2@tip-bot2>
References: <176535283007.498.16442167388418039352.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176552918977.498.14365164604517270330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ac87efcf9e42f07526438b67405659a8c1d0480e
Gitweb:        https://git.kernel.org/tip/ac87efcf9e42f07526438b67405659a8c1d=
0480e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 10 Dec 2025 08:36:18 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Dec 2025 09:38:14 +01:00

x86/boot/Documentation: Fix whitespace noise in boot.rst

There's a lot of unnecessary whitespace damage in this
file: space before tabs, etc., that has no formatting
or readability effect or advantages.

Fix them.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/176535283007.498.16442167388418039352.tip-bot2=
@tip-bot2
---
 Documentation/arch/x86/boot.rst | 194 +++++++++++++++----------------
 1 file changed, 97 insertions(+), 97 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 18574f0..dca3875 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -95,26 +95,26 @@ Memory Layout
 The traditional memory map for the kernel loader, used for Image or
 zImage kernels, typically looks like::
=20
-  		|  			 |
+		|  			 |
   0A0000	+------------------------+
-  		|  Reserved for BIOS	 |	Do not use.  Reserved for BIOS EBDA.
+		|  Reserved for BIOS	 |	Do not use.  Reserved for BIOS EBDA.
   09A000	+------------------------+
-  		|  Command line		 |
-  		|  Stack/heap		 |	For use by the kernel real-mode code.
+		|  Command line		 |
+		|  Stack/heap		 |	For use by the kernel real-mode code.
   098000	+------------------------+
-  		|  Kernel setup		 |	The kernel real-mode code.
+		|  Kernel setup		 |	The kernel real-mode code.
   090200	+------------------------+
-  		|  Kernel boot sector	 |	The kernel legacy boot sector.
+		|  Kernel boot sector	 |	The kernel legacy boot sector.
   090000	+------------------------+
-  		|  Protected-mode kernel |	The bulk of the kernel image.
+		|  Protected-mode kernel |	The bulk of the kernel image.
   010000	+------------------------+
-  		|  Boot loader		 |	<- Boot sector entry point 0000:7C00
+		|  Boot loader		 |	<- Boot sector entry point 0000:7C00
   001000	+------------------------+
-  		|  Reserved for MBR/BIOS |
+		|  Reserved for MBR/BIOS |
   000800	+------------------------+
-  		|  Typically used by MBR |
+		|  Typically used by MBR |
   000600	+------------------------+
-  		|  BIOS use only	 |
+		|  BIOS use only	 |
   000000	+------------------------+
=20
 When using bzImage, the protected-mode kernel was relocated to
@@ -142,27 +142,27 @@ above the 0x9A000 point; too many BIOSes will break abo=
ve that point.
 For a modern bzImage kernel with boot protocol version >=3D 2.02, a
 memory layout like the following is suggested::
=20
-  		~  			 ~
-  		|  Protected-mode kernel |
+		~  			 ~
+		|  Protected-mode kernel |
   100000	+------------------------+
-  		|  I/O memory hole	 |
+		|  I/O memory hole	 |
   0A0000	+------------------------+
-  		|  Reserved for BIOS	 |	Leave as much as possible unused
-  		~  			 ~
-  		|  Command line		 |	(Can also be below the X+10000 mark)
+		|  Reserved for BIOS	 |	Leave as much as possible unused
+		~  			 ~
+		|  Command line		 |	(Can also be below the X+10000 mark)
   X+10000	+------------------------+
-  		|  Stack/heap		 |	For use by the kernel real-mode code.
+		|  Stack/heap		 |	For use by the kernel real-mode code.
   X+08000	+------------------------+
-  		|  Kernel setup		 |	The kernel real-mode code.
-  		|  Kernel boot sector	 |	The kernel legacy boot sector.
+		|  Kernel setup		 |	The kernel real-mode code.
+		|  Kernel boot sector	 |	The kernel legacy boot sector.
   X		+------------------------+
-  		|  Boot loader		 |	<- Boot sector entry point 0000:7C00
+		|  Boot loader		 |	<- Boot sector entry point 0000:7C00
   001000	+------------------------+
-  		|  Reserved for MBR/BIOS |
+		|  Reserved for MBR/BIOS |
   000800	+------------------------+
-  		|  Typically used by MBR |
+		|  Typically used by MBR |
   000600	+------------------------+
-  		|  BIOS use only	 |
+		|  BIOS use only	 |
   000000	+------------------------+
=20
   ... where the address X is as low as the design of the boot loader permits.
@@ -809,12 +809,12 @@ Protocol:	2.09+
   as follow::
=20
    struct setup_data {
-   	__u64 next;
-   	__u32 type;
-   	__u32 len;
-   	__u8 data[];
+	__u64 next;
+	__u32 type;
+	__u32 len;
+	__u8 data[];
    }
-  =20
+
   Where, the next is a 64-bit physical pointer to the next node of
   linked list, the next field of the last node is 0; the type is used
   to identify the contents of data; the len is the length of data
@@ -835,10 +835,10 @@ Protocol:	2.09+
   protocol 2.15::
=20
    struct setup_indirect {
-   	__u32 type;
-   	__u32 reserved;		/* Reserved, must be set to zero. */
-   	__u64 len;
-   	__u64 addr;
+	__u32 type;
+	__u32 reserved;		/* Reserved, must be set to zero. */
+	__u64 len;
+	__u64 addr;
    };
=20
   The type member is a SETUP_INDIRECT | SETUP_* type. However, it cannot be
@@ -850,15 +850,15 @@ Protocol:	2.09+
   In this case setup_data and setup_indirect will look like this::
=20
    struct setup_data {
-   	.next =3D 0,	/* or <addr_of_next_setup_data_struct> */
-   	.type =3D SETUP_INDIRECT,
-   	.len =3D sizeof(setup_indirect),
-   	.data[sizeof(setup_indirect)] =3D (struct setup_indirect) {
-   		.type =3D SETUP_INDIRECT | SETUP_E820_EXT,
-   		.reserved =3D 0,
-   		.len =3D <len_of_SETUP_E820_EXT_data>,
-   		.addr =3D <addr_of_SETUP_E820_EXT_data>,
-   	},
+	.next =3D 0,	/* or <addr_of_next_setup_data_struct> */
+	.type =3D SETUP_INDIRECT,
+	.len =3D sizeof(setup_indirect),
+	.data[sizeof(setup_indirect)] =3D (struct setup_indirect) {
+		.type =3D SETUP_INDIRECT | SETUP_E820_EXT,
+		.reserved =3D 0,
+		.len =3D <len_of_SETUP_E820_EXT_data>,
+		.addr =3D <addr_of_SETUP_E820_EXT_data>,
+	},
    }
=20
 .. note::
@@ -897,11 +897,11 @@ Offset/size:	0x260/4
   The kernel runtime start address is determined by the following algorithm::
=20
    if (relocatable_kernel) {
-    	if (load_address < pref_address)
-    		load_address =3D pref_address;
-    	runtime_start =3D align_up(load_address, kernel_alignment);
+	if (load_address < pref_address)
+		load_address =3D pref_address;
+	runtime_start =3D align_up(load_address, kernel_alignment);
    } else {
-    	runtime_start =3D pref_address;
+	runtime_start =3D pref_address;
    }
=20
 Hence the necessary memory window location and size can be estimated by
@@ -975,22 +975,22 @@ after kernel_info_var_len_data label. Each chunk of var=
iable size data has to
 be prefixed with header/magic and its size, e.g.::
=20
   kernel_info:
-  	.ascii  "LToP"		/* Header, Linux top (structure). */
-  	.long   kernel_info_var_len_data - kernel_info
-  	.long   kernel_info_end - kernel_info
-  	.long   0x01234567	/* Some fixed size data for the bootloaders. */
+	.ascii  "LToP"		/* Header, Linux top (structure). */
+	.long   kernel_info_var_len_data - kernel_info
+	.long   kernel_info_end - kernel_info
+	.long   0x01234567	/* Some fixed size data for the bootloaders. */
   kernel_info_var_len_data:
   example_struct:		/* Some variable size data for the bootloaders. */
-  	.ascii  "0123"		/* Header/Magic. */
-  	.long   example_struct_end - example_struct
-  	.ascii  "Struct"
-  	.long   0x89012345
+	.ascii  "0123"		/* Header/Magic. */
+	.long   example_struct_end - example_struct
+	.ascii  "Struct"
+	.long   0x89012345
   example_struct_end:
   example_strings:		/* Some variable size data for the bootloaders. */
-  	.ascii  "ABCD"		/* Header/Magic. */
-  	.long   example_strings_end - example_strings
-  	.asciz  "String_0"
-  	.asciz  "String_1"
+	.ascii  "ABCD"		/* Header/Magic. */
+	.long   example_strings_end - example_strings
+	.asciz  "String_0"
+	.asciz  "String_1"
   example_strings_end:
   kernel_info_end:
=20
@@ -1132,53 +1132,53 @@ Such a boot loader should enter the following fields =
in the header::
   unsigned long base_ptr;	/* base address for real-mode segment */
=20
   if (setup_sects =3D=3D 0)
-  	setup_sects =3D 4;
+	setup_sects =3D 4;
=20
   if (protocol >=3D 0x0200) {
-  	type_of_loader =3D <type code>;
-  	if (loading_initrd) {
-  		ramdisk_image =3D <initrd_address>;
-  		ramdisk_size =3D <initrd_size>;
-  	}
-
-  	if (protocol >=3D 0x0202 && loadflags & 0x01)
-  		heap_end =3D 0xe000;
-  	else
-  		heap_end =3D 0x9800;
-
-  	if (protocol >=3D 0x0201) {
-  		heap_end_ptr =3D heap_end - 0x200;
-  		loadflags |=3D 0x80;		/* CAN_USE_HEAP */
-  	}
-
-  	if (protocol >=3D 0x0202) {
-  		cmd_line_ptr =3D base_ptr + heap_end;
-  		strcpy(cmd_line_ptr, cmdline);
-  	} else {
-  		cmd_line_magic	=3D 0xA33F;
-  		cmd_line_offset =3D heap_end;
-  		setup_move_size =3D heap_end + strlen(cmdline) + 1;
-  		strcpy(base_ptr + cmd_line_offset, cmdline);
-  	}
+	type_of_loader =3D <type code>;
+	if (loading_initrd) {
+		ramdisk_image =3D <initrd_address>;
+		ramdisk_size =3D <initrd_size>;
+	}
+
+	if (protocol >=3D 0x0202 && loadflags & 0x01)
+		heap_end =3D 0xe000;
+	else
+		heap_end =3D 0x9800;
+
+	if (protocol >=3D 0x0201) {
+		heap_end_ptr =3D heap_end - 0x200;
+		loadflags |=3D 0x80;		/* CAN_USE_HEAP */
+	}
+
+	if (protocol >=3D 0x0202) {
+		cmd_line_ptr =3D base_ptr + heap_end;
+		strcpy(cmd_line_ptr, cmdline);
+	} else {
+		cmd_line_magic	=3D 0xA33F;
+		cmd_line_offset =3D heap_end;
+		setup_move_size =3D heap_end + strlen(cmdline) + 1;
+		strcpy(base_ptr + cmd_line_offset, cmdline);
+	}
   } else {
-  	/* Very old kernel */
+	/* Very old kernel */
=20
-  	heap_end =3D 0x9800;
+	heap_end =3D 0x9800;
=20
-  	cmd_line_magic	=3D 0xA33F;
-  	cmd_line_offset =3D heap_end;
+	cmd_line_magic	=3D 0xA33F;
+	cmd_line_offset =3D heap_end;
=20
-  	/* A very old kernel MUST have its real-mode code loaded at 0x90000 */
-  	if (base_ptr !=3D 0x90000) {
-  		/* Copy the real-mode kernel */
-  		memcpy(0x90000, base_ptr, (setup_sects + 1) * 512);
-  		base_ptr =3D 0x90000;		 /* Relocated */
-  	}
+	/* A very old kernel MUST have its real-mode code loaded at 0x90000 */
+	if (base_ptr !=3D 0x90000) {
+		/* Copy the real-mode kernel */
+		memcpy(0x90000, base_ptr, (setup_sects + 1) * 512);
+		base_ptr =3D 0x90000;		 /* Relocated */
+	}
=20
-  	strcpy(0x90000 + cmd_line_offset, cmdline);
+	strcpy(0x90000 + cmd_line_offset, cmdline);
=20
-  	/* It is recommended to clear memory up to the 32K mark */
-  	memset(0x90000 + (setup_sects + 1) * 512, 0, (64 - (setup_sects + 1)) * 5=
12);
+	/* It is recommended to clear memory up to the 32K mark */
+	memset(0x90000 + (setup_sects + 1) * 512, 0, (64 - (setup_sects + 1)) * 512=
);
   }
=20
=20

