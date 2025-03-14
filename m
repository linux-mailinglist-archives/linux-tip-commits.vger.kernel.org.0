Return-Path: <linux-tip-commits+bounces-4210-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA68EA60DF2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 10:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68E316371D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0521DE89E;
	Fri, 14 Mar 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fwEnK1d2"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB281C8623
	for <linux-tip-commits@vger.kernel.org>; Fri, 14 Mar 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945994; cv=none; b=Lqa9oVpR3LkSib3PDBup4fGGhiHAqsGldkL7YnsIbizbiJg4nLD9NjAUzIV5r5Lo5JlXEPAGc1iVYpg3+AnpL1EzCpoYGMyRdt+Oq5gwD49OWi1mUKgQhm41kMHvj617TAQAyYge9Kn0+J/nFg2IRAiONsg/tzhs4fd4v5l9cr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945994; c=relaxed/simple;
	bh=dXEa7DXyMnjs0YUJhQahFmGOaPqYj3vY8JNE+Sku6XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Was1mCupeYdMffor8Ex66HlySY4YBGNjzQ136bwglJuoED9iB7/N/Oz9Dfm5bhH8cw/r7yTJ/lt+YDisWN2Ks8gAF+bGcY45dH47em5l+MmliWOkUYXbTsf2moRelv8tDn3a6PTbLwQNAaMVwIR5qUAKaFjQ6DqzQMXhRqCg4dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fwEnK1d2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso12839325e9.3
        for <linux-tip-commits@vger.kernel.org>; Fri, 14 Mar 2025 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741945990; x=1742550790; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dXEa7DXyMnjs0YUJhQahFmGOaPqYj3vY8JNE+Sku6XE=;
        b=fwEnK1d2RdsxWQcCowdt3h7h/5H6+0JsiwwyQwnp0sLNhNcZvcmc4yqgjXYMwh0/CW
         YkhgWR96C1PFr4sJJ+ML5P31fhyydUlrEjYf4VBjJZ+bXOjYZvdk9CnZT2CdrccyQAI0
         jSpnzqZN+LJxOLC1D47GlerUvlcITIi5UXFWnrtbsKlzEMsAdA7wyQUtCUkU7fWIZYLc
         noF1rxCybSRJ7Lx7U2b1YIiu/JgPD6n7KGjKkOEqvUSQ6NkmnGgf7CIvK16D7OwK3LgW
         V8JCb9Nk1GQVpjdhPlYITuGWV9y+FQpyzCJgqSbWwrfrP7ySrbWhF5FFTr8GlSeH1aml
         +YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741945990; x=1742550790;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXEa7DXyMnjs0YUJhQahFmGOaPqYj3vY8JNE+Sku6XE=;
        b=RmcZJ9ro/G8QJEa80Rjd9cdsR2pFKci1JjUTkbs9XNYquuIpAUtUKof0zKxmvP508M
         OxkzKx/SlOGwdyzzgFLH59Y++ssVAu2jt6ZFd8oc6bgCQ2UIar5u4/DzsZ8kd75HslLp
         Y62dcaeE10jfMS/n+JqTnbPmSrleKSv3dwdCC+UrmbK8nMBe6TqS12iTFZQ/OJqq9JAh
         XyYOQOsGi/ADqJsN94sVkn6XEcwpX1vcEXUHRs4aylZ26asxlRJP7eWZUKgzlGq85sAQ
         L8JaGLEFsbp3En8GcBC7orUXFI6pYg7V6KC6yofulnFSELMJMtweTx8DhsKmJhk8Tp69
         khwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7EfuMory8V72xNKJjCz4HnnV6EuAvHdwix0K84B9cJHeA5EI5t/qOmnFKnGVAhiieD3Df0plvBqg5ijVVkf5p1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYlaJtWcS12deT05ARqvlJKMjox7+tIHa9JDh6OOKLsUXyLKC
	S5MygYns4H5Rg4oYAG0x+fPt4VvHOtwAYJgQzQNk2sacacM3aHyZtjZqIvYVNp4=
X-Gm-Gg: ASbGnctyrJ0kzPdwi03OVk5b5KpdJ0DDQFNYmrwuA4SuKJJ8DPJROt1SH061Ip7t4ts
	unDL7vRf1rjezxEdyFvqQHEY8qh43mbhE5q5+0e3XEkOiFVAig795jTTmygRbn6kZo89OjP/iDO
	A40GoUWx+q5uYFEHAsBD7k28JMtMrKF8/0FRj6/ooV6LVDeuSeZgqqpXTq/Hzei8zkVm2hFQRSK
	Ka/40wTIja8THF4UELRks78Db60r+z+qTePIkpQEZlSlt6Ixxi73p6jHO8qrjokw3LHtBKLBYw9
	eC1Rs4At4U3P+xgTo0jn4em8C+R1EHK+Ms5C0Ds/D9Gd2YSPAqDmfTawPqdYzPnmLnkHQdox/M3
	YmV9Ber8ht89D22Ygsg8YG6Nnm5naeOF+SSl1NzMGAM/t50jxqjvK2TGoZk6z0XvuJ9PGaKVVKB
	WkFA==
X-Google-Smtp-Source: AGHT+IGhwUFjSIIUOQd7bAPAM96zTQNHgZ/9a89AQnOE9xgSDOX2sT0NK3JZYN8pQ/Ebu8dUjhikGg==
X-Received: by 2002:a05:600c:4eca:b0:43d:bb9:ad00 with SMTP id 5b1f17b1804b1-43d1ecc7d78mr23970425e9.15.1741945990174;
        Fri, 14 Mar 2025 02:53:10 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fad4dsm11847555e9.29.2025.03.14.02.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 02:53:09 -0700 (PDT)
Message-ID: <c54d69f0-cda6-4793-bffb-1a0c1e5e9d92@suse.com>
Date: Fri, 14 Mar 2025 10:53:08 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/cpu] x86/xen: Move Xen upcall handler to Xen specific
 code files
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
References: <20250313182236.655724-2-brgerst@gmail.com>
 <174194562029.14745.12496349660371729484.tip-bot2@tip-bot2>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <174194562029.14745.12496349660371729484.tip-bot2@tip-bot2>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------a9i6IVhlJfgaU4YiGd8AxQqU"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------a9i6IVhlJfgaU4YiGd8AxQqU
Content-Type: multipart/mixed; boundary="------------TnDV6qaaHevbOsoXSNuE9yjx";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Message-ID: <c54d69f0-cda6-4793-bffb-1a0c1e5e9d92@suse.com>
Subject: Re: [tip: x86/cpu] x86/xen: Move Xen upcall handler to Xen specific
 code files
References: <20250313182236.655724-2-brgerst@gmail.com>
 <174194562029.14745.12496349660371729484.tip-bot2@tip-bot2>
In-Reply-To: <174194562029.14745.12496349660371729484.tip-bot2@tip-bot2>

--------------TnDV6qaaHevbOsoXSNuE9yjx
Content-Type: multipart/mixed; boundary="------------GXbROLg0yqdvess2e93DJTHJ"

--------------GXbROLg0yqdvess2e93DJTHJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMDMuMjUgMTA6NDcsIHRpcC1ib3QyIGZvciBCcmlhbiBHZXJzdCB3cm90ZToNCj4g
VGhlIGZvbGxvd2luZyBjb21taXQgaGFzIGJlZW4gbWVyZ2VkIGludG8gdGhlIHg4Ni9jcHUg
YnJhbmNoIG9mIHRpcDoNCj4gDQo+IENvbW1pdC1JRDogICAgIDgyN2RjMmUzNjE3MmU5Nzhk
NmIxYzcwMWIwNGJlZTU2ODgxZjU0YmYNCj4gR2l0d2ViOiAgICAgICAgaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy90aXAvODI3ZGMyZTM2MTcyZTk3OGQ2YjFjNzAxYjA0YmVlNTY4ODFmNTRi
Zg0KPiBBdXRob3I6ICAgICAgICBCcmlhbiBHZXJzdCA8YnJnZXJzdEBnbWFpbC5jb20+DQo+
IEF1dGhvckRhdGU6ICAgIFRodSwgMTMgTWFyIDIwMjUgMTQ6MjI6MzIgLTA0OjAwDQo+IENv
bW1pdHRlcjogICAgIEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPiBDb21taXR0
ZXJEYXRlOiBGcmksIDE0IE1hciAyMDI1IDEwOjMyOjUxICswMTowMA0KPiANCj4geDg2L3hl
bjogTW92ZSBYZW4gdXBjYWxsIGhhbmRsZXIgdG8gWGVuIHNwZWNpZmljIGNvZGUgZmlsZXMN
Cj4gDQo+IE1vdmUgdGhlIHVwY2FsbCBoYW5kbGVyIHRvIFhlbi1zcGVjaWZpYyBmaWxlcy4N
Cj4gDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJy
aWFuIEdlcnN0IDxicmdlcnN0QGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSW5nbyBN
b2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBTb2hpbCBNZWh0YSA8
c29oaWwubWVodGFAaW50ZWwuY29tPg0KPiBDYzogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtl
cm5lbC5vcmc+DQo+IENjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IENj
OiBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4NCj4gQ2M6IExpbnVzIFRvcnZhbGRz
IDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gQ2M6IEpvc2ggUG9pbWJvZXVm
IDxqcG9pbWJvZUByZWRoYXQuY29tPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzIwMjUwMzEzMTgyMjM2LjY1NTcyNC0yLWJyZ2Vyc3RAZ21haWwuY29tDQoNCldoeSBk
byBJIGV2ZW4gcmVxdWVzdCBjaGFuZ2VzIGlmIHN1Y2ggYSByZXF1ZXN0IGlzIGJlaW5nIGln
bm9yZWQ/DQoNClBsZWFzZSBub3RlIHRoYXQgbXkgcmVxdWVzdCB3YXNuJ3QgYWJvdXQgc29t
ZXRoaW5nIHdoaWNoIHNob3VsZCBiZSBoYW5kbGVkDQppbiBhIGZvbGxvd3VwIHBhdGNoLiBJ
IHdhcyBhc2tpbmcgdG8gTk9UIG1vdmUgdGhlIGNvZGUgaW50byBtdWx0aXBsZSBmaWxlcywN
CmJ1dCB0byBrZWVwIGl0IGluIG9uZSBmaWxlIGFzIGl0IHdhcyBvcmlnaW5hbGx5Lg0KDQoN
Ckp1ZXJnZW4NCg==
--------------GXbROLg0yqdvess2e93DJTHJ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------GXbROLg0yqdvess2e93DJTHJ--

--------------TnDV6qaaHevbOsoXSNuE9yjx--

--------------a9i6IVhlJfgaU4YiGd8AxQqU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfT/IQFAwAAAAAACgkQsN6d1ii/Ey+N
Mgf9HTPyzGahMWU+cwv7YHnr/vFiqaJlKzT8xifGdPXTWnBzsUadHpAZnGBuqfsLvHUEF9lBrCwi
D30WI/ifNBpR1ZHMuv3MdFU+fXYg5aTOZx27Hco0/hkKilucVQDTN5haUslavsOTqMBJdmYOewcX
hBwG9vVhLrYAtgkU4Z1Beda40x4HIW6zCy/ox1/EUjSpC03Juov+//5BPdhAd/X7iGTgND82pBIg
yjRBWzxgMVTXe8EMV5x+xShoT9K6ODF0u5MuCuT3YDB5tTWzV0Yd2DMQKhPnaOi304jQrgMOTF2r
p6nWtqe6BwbNJ0Ey/6AZlBXeZjy+Y9sP+ADmuMh3QQ==
=OkaO
-----END PGP SIGNATURE-----

--------------a9i6IVhlJfgaU4YiGd8AxQqU--

