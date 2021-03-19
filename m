Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B6A3420C2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 16:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhCSPUi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 11:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhCSPUb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 11:20:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B2E761928;
        Fri, 19 Mar 2021 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616167231;
        bh=sTGLqdIs2MV7mqHtbPaujFy8brCYCDlq2ZsMQW7m7G0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQK93UavMp8P7tsjusXiO5B6TMZfdRRuuWN0QwiHNIdnlzLSNVPoNcuvpMCITwzkF
         VXXkZBXiX7fj1n/A/2Envyp7RpIwpcT2aPMsTzh5K/Zm2/H3l6yl0s+g6Nxa3PWQep
         HK1PY3ETJaDfDCHXz+bMV5G7Z+GC2GgNArYMphlwAKi1Wym0jY/zIejTcA7LYEQTqe
         EKTNyX26si8O/u43vR016OgC30e4SvyTyOATgUMm2FCCZUDydZEF9BvfOqf6OEQCue
         1YwTK7d2GpSsmkKj+tCJenDeKcrgwYwzW7TFXVdIy2nwU2Ab7CUt3sBMwrwAQ2scm3
         XQD6mKuwcJYDg==
Date:   Fri, 19 Mar 2021 17:20:04 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/sgx] selftests/sgx: Improve error detection and
 messages
Message-ID: <YFTBJDlyvyUr2mfh@kernel.org>
References: <20210318194301.11D9A984@viggo.jf.intel.com>
 <161615392429.398.565615269339667317.tip-bot2@tip-bot2>
 <20210319145807.GG6251@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319145807.GG6251@zn.tnic>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Mar 19, 2021 at 03:58:07PM +0100, Borislav Petkov wrote:
> On Fri, Mar 19, 2021 at 11:38:44AM -0000, tip-bot2 for Dave Hansen wrote:
> >  tools/testing/selftests/sgx/load.c | 66 ++++++++++++++++++++++-------
> >  tools/testing/selftests/sgx/main.c |  2 +-
> >  2 files changed, 53 insertions(+), 15 deletions(-)
> 
> Anything against some more tweaks ontop?

Nope :-)

> ---
> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
> index 4c149f46d798..f441ac34b4d4 100644
> --- a/tools/testing/selftests/sgx/load.c
> +++ b/tools/testing/selftests/sgx/load.c
> @@ -156,7 +156,7 @@ bool encl_load(const char *path, struct encl *encl)
>  	 * the owner or in the owning group.
>  	 */
>  	if (!(sb.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))) {
> -		fprintf(stderr, "no execute permissions on device file\n");
> +		fprintf(stderr, "no execute permissions on device file %s\n", device_path);
>  		goto err;
>  	}
>  
> @@ -167,12 +167,15 @@ bool encl_load(const char *path, struct encl *encl)
>  	}
>  	munmap(ptr, PAGE_SIZE);
>  
> +#define ERR_MSG \
> +"mmap() succeeded for PROT_READ, but failed for PROT_EXEC.\n" \
> +" Check that current user has execute permissions on %s and \n" \
> +" that /dev does not have noexec set: mount | grep \"/dev .*noexec\"\n" \
> +" If so, remount it executable: mount -o remount,exec /dev\n\n"
> +
>  	ptr = mmap(NULL, PAGE_SIZE, PROT_EXEC, MAP_SHARED, fd, 0);
>  	if (ptr == (void *)-1) {
> -		perror("ERROR: mmap for exec");
> -		fprintf(stderr, "mmap() succeeded for PROT_READ, but failed for PROT_EXEC\n");
> -		fprintf(stderr, "check that user has execute permissions on %s and\n", device_path);
> -		fprintf(stderr, "that /dev does not have noexec set: 'mount | grep \"/dev .*noexec\"'\n");
> +		fprintf(stderr, ERR_MSG, device_path);
>  		goto err;
>  	}
>  	munmap(ptr, PAGE_SIZE);
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

Printing device path is a good sanity thing to have, thanks.

/Jarkko
